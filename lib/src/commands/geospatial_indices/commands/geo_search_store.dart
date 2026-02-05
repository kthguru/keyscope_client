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

import '../commands.dart' show GeospatialIndicesCommands;

extension GeoSearchStoreCommand on GeospatialIndicesCommands {
  /// GEOSEARCHSTORE destination source [FROMMEMBER member]
  /// [FROMLONLAT longitude latitude] [BYRADIUS radius m|km|ft|mi]
  /// [BYBOX width height m|km|ft|mi] [ASC|DESC] [COUNT count [ANY]]
  /// `[STOREDIST]`
  ///
  /// This command is like GEOSEARCH, but stores the result in
  /// [destination] key.
  Future<int> geoSearchStore(
    String destination,
    String source, {
    String? fromMember,
    List<double>? fromLonLat,
    List<dynamic>? byRadius, // [radius, unit]
    List<dynamic>? byBox, // [width, height, unit]
    String? sort, // ASC or DESC
    int? count,
    bool any = false,
    bool storeDist = false,
  }) async {
    final cmd = <String>['GEOSEARCHSTORE', destination, source];

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
    if (sort != null) cmd.add(sort);
    if (count != null) {
      cmd.add('COUNT');
      cmd.add(count.toString());
      if (any) cmd.add('ANY');
    }
    if (storeDist) cmd.add('STOREDIST');

    return executeInt(cmd);
  }
}
