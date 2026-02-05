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

extension GeoHashCommand on GeospatialIndicesCommands {
  /// GEOHASH key member [member ...]
  ///
  /// Returns valid Geohash strings representing the position of
  /// one or more elements.
  ///
  /// Returns:
  /// - [List<String?>]: Array of Geohash strings, or null if
  /// a member doesn't exist.
  Future<List<String?>> geoHash(String key, List<String> members) async {
    final cmd = <String>['GEOHASH', key, ...members];
    final result = await execute(cmd);
    if (result is List) {
      return result.map((e) => e?.toString()).toList();
    }
    return [];
  }
}
