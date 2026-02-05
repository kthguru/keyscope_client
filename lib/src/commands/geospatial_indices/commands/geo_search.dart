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

import '../commands.dart' show GeoRadiusOptions, GeospatialIndicesCommands;

extension GeoSearchCommand on GeospatialIndicesCommands {
  /// GEOSEARCH key [FROMMEMBER member] [FROMLONLAT longitude latitude]
  /// [BYRADIUS radius m|km|ft|mi] [BYBOX width height m|km|ft|mi] [ASC|DESC]
  /// [COUNT count [ANY]] `[WITHCOORD]` `[WITHDIST]` `[WITHHASH]`
  ///
  /// Return the members of a sorted set populated with geospatial information,
  /// which are within the borders of the area specified with the center
  /// location and the maximum distance from the center.
  ///
  /// Parameters:
  /// - [fromMember]: Use existing member as center.
  /// - [fromLonLat]: Use longitude/latitude as center (List of 2 doubles).
  /// - [byRadius]: Search within radius (List: [radius, unit]).
  /// - [byBox]: Search within box (List: [width, height, unit]).
  Future<dynamic> geoSearch(
    String key, {
    String? fromMember,
    List<double>? fromLonLat,
    List<dynamic>? byRadius, // [radius, unit]
    List<dynamic>? byBox, // [width, height, unit]
    GeoRadiusOptions? options,
  }) async {
    final cmd = <String>['GEOSEARCH', key];

    // Center point
    if (fromMember != null) {
      cmd.add('FROMMEMBER');
      cmd.add(fromMember);
    } else if (fromLonLat != null && fromLonLat.length == 2) {
      cmd.add('FROMLONLAT');
      cmd.add(fromLonLat[0].toString());
      cmd.add(fromLonLat[1].toString());
    } else {
      throw ArgumentError('Either fromMember or fromLonLat must be provided.');
    }

    // Search area
    if (byRadius != null && byRadius.length == 2) {
      cmd.add('BYRADIUS');
      cmd.add(byRadius[0].toString());
      cmd.add(byRadius[1].toString());
    } else if (byBox != null && byBox.length == 3) {
      cmd.add('BYBOX');
      cmd.add(byBox[0].toString());
      cmd.add(byBox[1].toString());
      cmd.add(byBox[2].toString());
    } else {
      throw ArgumentError('Either byRadius or byBox must be provided.');
    }

    // Options
    if (options != null) {
      if (options.sort != null) cmd.add(options.sort!);
      if (options.count != null) {
        cmd.add('COUNT');
        cmd.add(options.count.toString());
        if (options.any ?? false) cmd.add('ANY');
      }
      if (options.withCoord) cmd.add('WITHCOORD');
      if (options.withDist) cmd.add('WITHDIST');
      if (options.withHash) cmd.add('WITHHASH');
    }

    return execute(cmd);
  }
}
