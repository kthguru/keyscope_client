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

extension GeoRadiusRoCommand on GeospatialIndicesCommands {
  /// GEORADIUS_RO key longitude latitude radius m|km|ft|mi
  /// [WITHCOORD] [WITHDIST] [WITHHASH] [COUNT count [ANY]] [ASC|DESC]
  ///
  /// Read-only variant of GEORADIUS.
  Future<dynamic> geoRadiusRo(
    String key,
    double longitude,
    double latitude,
    double radius,
    String unit, {
    GeoRadiusOptions? options,
  }) async {
    final cmd = <String>[
      'GEORADIUS_RO',
      key,
      longitude.toString(),
      latitude.toString(),
      radius.toString(),
      unit
    ];

    if (options != null) {
      if (options.withCoord) cmd.add('WITHCOORD');
      if (options.withDist) cmd.add('WITHDIST');
      if (options.withHash) cmd.add('WITHHASH');
      if (options.count != null) {
        cmd.add('COUNT');
        cmd.add(options.count.toString());
        if (options.any ?? false) cmd.add('ANY');
      }
      if (options.sort != null) cmd.add(options.sort!);
    }

    return execute(cmd);
  }
}
