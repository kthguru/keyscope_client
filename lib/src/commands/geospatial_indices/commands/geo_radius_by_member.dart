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

extension GeoRadiusByMemberCommand on GeospatialIndicesCommands {
  /// GEORADIUSBYMEMBER key member radius m|km|ft|mi
  /// [WITHCOORD] [WITHDIST] [WITHHASH] [COUNT count [ANY]] [ASC|DESC]
  /// [STORE key] [STOREDIST key]
  ///
  /// **Redis**
  /// As of Redis version 6.2.0, this command is regarded as deprecated.
  /// Deprecated: Use GEOSEARCH instead.
  /// This command is exactly like GEORADIUS with the sole difference that
  /// instead of taking, as the center of the area to query, a longitude and
  /// latitude value, it takes the name of a member already existing inside
  /// the geospatial index represented by the sorted set.
  ///
  /// **Valkey**: Available.
  Future<dynamic> geoRadiusByMember(
    String key,
    String member,
    double radius,
    String unit, {
    GeoRadiusOptions? options,
    String? store,
    String? storeDist,
  }) async {
    final cmd = <String>[
      'GEORADIUSBYMEMBER',
      key,
      member,
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

    if (store != null) {
      cmd.add('STORE');
      cmd.add(store);
    }
    if (storeDist != null) {
      cmd.add('STOREDIST');
      cmd.add(storeDist);
    }

    return execute(cmd);
  }
}
