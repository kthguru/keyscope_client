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

import '../commands.dart' show GeoLocation, GeospatialIndicesCommands;

extension GeoAddCommand on GeospatialIndicesCommands {
  /// GEOADD key [NX | XX] `[CH]` longitude latitude member
  /// [longitude latitude member ...]
  ///
  /// Adds the specified geospatial items (longitude, latitude, name) to
  /// the specified key.
  ///
  /// Options:
  /// - [nx]: Don't update already existing elements. Always add new elements.
  /// - [xx]: Only update elements that already exist. Never add elements.
  /// - [ch]: Modify the return value from the number of new elements added,
  /// to the total number of elements changed.
  ///
  /// Returns:
  /// - [int]: Number of elements added to the sorted set (or changed if CH is
  /// specified).
  Future<int> geoAdd(
    String key,
    List<GeoLocation> items, {
    bool nx = false,
    bool xx = false,
    bool ch = false,
  }) async {
    final cmd = <String>['GEOADD', key];
    if (nx) cmd.add('NX');
    if (xx) cmd.add('XX');
    if (ch) cmd.add('CH');

    for (final item in items) {
      cmd.add(item.longitude.toString());
      cmd.add(item.latitude.toString());
      cmd.add(item.member);
    }
    return executeInt(cmd);
  }
}
