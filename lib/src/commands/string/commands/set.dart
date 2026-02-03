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

import '../commands.dart' show StringCommands;

extension SetCommand on StringCommands {
  /// SET key value [NX | XX] [GET] [EX seconds | PX milliseconds |
  /// EXAT timestamp | PXAT timestamp | KEEPTTL]
  ///
  /// Set [key] to hold the string [value].
  /// If [key] already holds a value, it is overwritten, regardless of its type.
  ///
  /// Options:
  /// - [nx]: Only set the key if it does not already exist.
  /// - [xx]: Only set the key if it already exist.
  /// - [get]: Return the old string stored at key, or nil if key did not exist.
  /// - [ex]: Set the specified expire time, in seconds.
  /// - [px]: Set the specified expire time, in milliseconds.
  /// - [exAt]: Set the specified Unix time at which the key will expire,
  /// in seconds.
  /// - [pxAt]: Set the specified Unix time at which the key will expire,
  /// in milliseconds.
  /// - [keepTtl]: Retain the time to live associated with the key.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [String]: 'OK' if SET was executed correctly.
  /// - [String]: The old value if [get] option is used.
  /// - [`null`]: If [nx] or [xx] condition was not met.
  Future<String?> set(
    String key,
    String value, {
    bool nx = false,
    bool xx = false,
    bool get = false,
    int? ex,
    int? px,
    int? exAt,
    int? pxAt,
    bool keepTtl = false,
  }) async {
    final cmd = <String>['SET', key, value];
    if (nx) cmd.add('NX');
    if (xx) cmd.add('XX');
    if (get) cmd.add('GET');
    if (ex != null) {
      cmd.add('EX');
      cmd.add(ex.toString());
    } else if (px != null) {
      cmd.add('PX');
      cmd.add(px.toString());
    } else if (exAt != null) {
      cmd.add('EXAT');
      cmd.add(exAt.toString());
    } else if (pxAt != null) {
      cmd.add('PXAT');
      cmd.add(pxAt.toString());
    } else if (keepTtl) {
      cmd.add('KEEPTTL');
    }

    final result = await execute(cmd);
    return result as String?;
  }
}
