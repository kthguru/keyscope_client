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

import 'package:typeredis/typeredis.dart';

Future<void> main() async {
  final client = TRClient(host: 'localhost', port: 6379);
  await client.connect();
  await client.flushAll();

  print('--- 🌏 TypeRedis Geospatial Example (US East Coast) ---\n');

  const key = 'us:east_coast:cities';

  // 1. GEOADD: Add major US cities
  // Coordinates: Longitude, Latitude
  print('1. Adding cities (NY, Philly, DC, Boston)...');
  await client.geoAdd(key, [
    GeoLocation(longitude: -74.0060, latitude: 40.7128, member: 'New York'),
    GeoLocation(longitude: -75.1652, latitude: 39.9526, member: 'Philadelphia'),
    GeoLocation(longitude: -77.0369, latitude: 38.9072, member: 'Washington'),
    GeoLocation(longitude: -71.0589, latitude: 42.3601, member: 'Boston'),
  ]);

  // 2. GEOPOS: Get coordinates
  print('\n2. Getting coordinates for New York...');
  final pos = await client.geoPos(key, ['New York']);
  if (pos[0] != null) {
    print('   New York: Long ${pos[0]![0]}, Lat ${pos[0]![1]}');
  }

  // 3. GEODIST: Calculate distance
  print('\n3. Calculating distance (New York <-> Philadelphia)...');
  final distMi = await client.geoDist(key, 'New York', 'Philadelphia', 'mi');
  print('   Distance: ${distMi?.toStringAsFixed(2)} mi'); // Approx 80~87 mi

  // 4. GEOHASH: Get Geohash strings
  print('\n4. Geohash strings...');
  final hashes = await client.geoHash(key, ['New York', 'Washington']);
  print('   New York: ${hashes[0]}');
  print('   Washington: ${hashes[1]}');

  // 5. GEOSEARCH (Modern Standard): Radius & Box Search
  print('\n5. Searching nearby cities (GEOSEARCH)...');

  // A. FROMMEMBER: Find cities within 125 miles of New York
  final nearNewYork = await client.geoSearch(
    key,
    fromMember: 'New York',
    byRadius: [125, 'mi'],
    options: const GeoSearchOptions(withDist: true, sort: 'ASC'),
  ) as List;

  print('   Cities within 125 mi of New York:');
  for (var item in nearNewYork) {
    // item: [member, distance]
    final row = item as List;
    print('   - ${row[0]}: ${row[1]} mi');
  }

  // B. FROMLONLAT: Find cities within 200 miles of a coordinate
  // (Near Philadelphia)
  final nearCoord = await client.geoSearch(
    key,
    fromLonLat: [-75.0, 40.0], // Near Philadelphia
    byRadius: [200, 'mi'],
    options: const GeoSearchOptions(withCoord: true),
  ) as List;

  print('   Cities within 200mi of (-75.0, 40.0):');
  for (var item in nearCoord) {
    // item: [member, [long, lat]]
    final row = item as List;
    print('   - ${row[0]}');
  }

  // C. BYBOX: Find cities within a rectangular area (Philadelphia context)
  // Define a box around the area between Philly and DC.
  // Width: 200 mi, Height: 200 mi
  print('\n   [BYBOX Search - Philadelphia]');
  final boxSearch1 = await client.geoSearch(
    key,
    fromMember: 'Philadelphia',
    byBox: [200, 200, 'mi'],
    options: const GeoSearchOptions(withCoord: true),
  ) as List;

  print('   Cities in 200x200 mi box around Philadelphia:');
  for (var item in boxSearch1) {
    // item: [member, [long, lat]]
    final row = item as List;
    print('   - ${row[0]}');
  }

  // D. BYBOX: Find cities within a rectangular area with LIMIT
  print('\n   [BYBOX Search - Washington (Limit 3)]');
  final boxSearch2 = await client.geoSearch(
    key,
    fromMember: 'Washington',
    byBox: [200, 200, 'mi'],
    options: const GeoSearchOptions(count: 3),
  ) as List;

  print('   Cities in 200x200 mi box around Washington (Limit 3):');
  for (var item in boxSearch2) {
    // No explicit cast needed here as we are just printing the String item
    print('   - $item');
  }

  // 6. GEOSEARCHSTORE: Store results
  print('\n6. Storing search results...');
  // Store neighbors of New York (within 300 miles) to a new key 'near:ny'
  // Store the distance as the score (STOREDIST)
  final stored = await client.geoSearchStore(
    'near:ny',
    key,
    fromMember: 'New York',
    byRadius: [300, 'mi'],
    storeDist: true,
  );
  print('   Stored $stored cities to "near:ny".');

  // Verify with ZRANGE
  final storedMembers = await client.zRange('near:ny', 0, -1, withScores: true);
  print('   Content of "near:ny" (Sorted by distance): $storedMembers');

  await client.close();
  print('\n--- Done ---');
}
