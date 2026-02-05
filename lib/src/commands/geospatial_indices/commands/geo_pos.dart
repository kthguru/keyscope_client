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

extension GeoPosCommand on GeospatialIndicesCommands {
  /// GEOPOS key member [member ...]
  ///
  /// Returns the positions (longitude,latitude) of all the specified members.
  ///
  /// Returns:
  /// - [List<List<double>?>]: A list where each element is a two-element list
  /// [long, lat], or null.
  Future<List<List<double>?>> geoPos(String key, List<String> members) async {
    final cmd = <String>['GEOPOS', key, ...members];
    final result = await execute(cmd);

    // Parse result: [[long, lat], null, [long, lat]]
    if (result is List) {
      return result
          .map((e) {
            if (e is List && e.length == 2) {
              return [
                double.parse(e[0].toString()),
                double.parse(e[1].toString())
              ];
            }
            return null; // Member not found
          })
          .toList()
          .cast<List<double>?>();
    }
    return [];
  }
}
