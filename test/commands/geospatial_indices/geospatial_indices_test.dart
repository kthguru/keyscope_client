/*
 * Copyright 2025-2026 Infradise Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:test/test.dart';
import 'package:typeredis/typeredis.dart';

void main() {
  group('Geospatial Commands', () {
    late TRClient client;

    setUp(() async {
      // Changed from ValkeyClient to TRClient
      client = TRClient(host: 'localhost', port: 6379);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      await client.close();
    });

    test('GEOADD, GEOPOS, GEOHASH', () async {
      const key = 'sicily';

      // 1. GEOADD
      // Add Palermo and Catania
      final count = await client.geoAdd(key, [
        GeoLocation(
            longitude: 13.361389, latitude: 38.115556, member: 'Palermo'),
        GeoLocation(
            longitude: 15.087269, latitude: 37.502669, member: 'Catania'),
      ]);
      expect(count, equals(2));

      // 2. GEOPOS
      final positions = await client.geoPos(key, ['Palermo', 'NonExisting']);

      // Check Palermo
      expect(positions[0], isNotNull);
      expect(positions[0]![0], closeTo(13.361389, 0.0001)); // Longitude
      expect(positions[0]![1], closeTo(38.115556, 0.0001)); // Latitude

      // Check NonExisting
      expect(positions[1], isNull);

      // 3. GEOHASH
      final hashes = await client.geoHash(key, ['Palermo', 'Catania']);
      expect(hashes.length, equals(2));
      expect(hashes[0], isNotNull);
      expect(hashes[1], isNotNull);
    });

    test('GEODIST', () async {
      const key = 'sicily';
      await client.geoAdd(key, [
        GeoLocation(
            longitude: 13.361389, latitude: 38.115556, member: 'Palermo'),
        GeoLocation(
            longitude: 15.087269, latitude: 37.502669, member: 'Catania'),
      ]);

      // Distance in meters (default)
      final distM = await client.geoDist(key, 'Palermo', 'Catania');
      expect(distM, greaterThan(100000)); // Approx 166km

      // Distance in km
      final distKm = await client.geoDist(key, 'Palermo', 'Catania', 'km');
      expect(distKm, closeTo(166.27, 1.0)); // Approx 166.27 km

      // Distance with missing member
      final distNull = await client.geoDist(key, 'Palermo', 'Nowhere');
      expect(distNull, isNull);
    });

    test('GEOSEARCH (Modern)', () async {
      const key = 'cities';
      await client.geoAdd(key, [
        GeoLocation(
            longitude: 13.361389, latitude: 38.115556, member: 'Palermo'),
        GeoLocation(
            longitude: 15.087269, latitude: 37.502669, member: 'Catania'),
      ]);

      // 1. FROMMEMBER & BYRADIUS
      // Search within 200km of Palermo
      final searchRes = await client.geoSearch(
        key,
        fromMember: 'Palermo',
        byRadius: [200, 'km'],
        options: const GeoRadiusOptions(withDist: true, sort: 'ASC'),
      );

      // Should find both Palermo (0km) and Catania (~166km)
      expect(searchRes, isA<List>());
      expect((searchRes as List).length, equals(2));

      // Result structure: [[member, dist], [member, dist]]
      final resList = searchRes;
      expect((resList[0] as List)[0], equals('Palermo'));
      expect((resList[1] as List)[0], equals('Catania'));

      // 2. FROMLONLAT & BYBOX
      // Search within a box around coordinates close to Catania
      final searchBox = await client.geoSearch(
        key,
        fromLonLat: [15.0, 37.5],
        byBox: [100, 100, 'km'], // width, height, unit
        options: const GeoRadiusOptions(withCoord: true),
      );

      expect(searchBox, isA<List>());
      // Should find Catania
      final catania =
          (searchBox as List).firstWhere((e) => (e as List)[0] == 'Catania');
      expect(catania, isNotNull);
    });

    test('GEOSEARCHSTORE', () async {
      const key = 'cities';
      await client.geoAdd(key, [
        GeoLocation(
            longitude: 13.361389, latitude: 38.115556, member: 'Palermo'),
        GeoLocation(
            longitude: 15.087269, latitude: 37.502669, member: 'Catania'),
      ]);

      // Store items within 200km of Palermo into 'results:sicily'
      final storedCount = await client.geoSearchStore(
        'results:sicily',
        key,
        fromMember: 'Palermo',
        byRadius: [200, 'km'],
        storeDist: true, // Store distance as score
      );

      expect(storedCount, equals(2));

      // Verify stored result (ZSET)
      // Palermo dist is 0.0, Catania is ~166.27
      final scoreCatania = await client.zScore('results:sicily', 'Catania');
      expect(scoreCatania, closeTo(166.27, 1.0));
    });

    test('Legacy GEORADIUS & GEORADIUSBYMEMBER', () async {
      const key = 'legacy';
      await client.geoAdd(key, [
        GeoLocation(
            longitude: 13.361389, latitude: 38.115556, member: 'Palermo'),
        GeoLocation(
            longitude: 15.087269, latitude: 37.502669, member: 'Catania'),
      ]);

      // 1. GEORADIUS
      final resRadius = await client.geoRadius(
        key,
        15.0, 37.5, // near Catania
        100, 'km',
        options: const GeoRadiusOptions(withDist: true),
      );
      expect(resRadius, isA<List>());
      expect((resRadius as List).length, equals(1)); // Only Catania

      expect((resRadius[0] as List)[0], equals('Catania'));

      // 2. GEORADIUSBYMEMBER
      final resMember = await client.geoRadiusByMember(
        key,
        'Palermo',
        200,
        'km',
      );
      expect(resMember, isA<List>());
      expect((resMember as List).length, equals(2)); // Palermo and Catania
    });
  });
}
