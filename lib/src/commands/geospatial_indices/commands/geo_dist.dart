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

extension GeoDistCommand on GeospatialIndicesCommands {
  /// GEODIST key member1 member2 [m|km|ft|mi]
  ///
  /// Returns the distance between two members in the geospatial index
  /// represented by the sorted set.
  ///
  /// Units: m (meters, default), km (kilometers), ft (feet), mi (miles).
  ///
  /// Returns:
  /// - [double?]: The distance in the specified unit, or null if one of
  /// the members doesn't exist.
  Future<double?> geoDist(String key, String member1, String member2,
      [String unit = 'm']) async {
    final cmd = <String>['GEODIST', key, member1, member2, unit];
    final result = await execute(cmd);
    if (result == null) return null;
    return double.tryParse(result.toString());
  }
}
