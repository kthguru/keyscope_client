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

extension GetExCommand on StringCommands {
  /// GETEX key [EX seconds | PX milliseconds | EXAT timestamp | PXAT timestamp
  /// | PERSIST]
  ///
  /// Get the value of [key] and optionally set its expiration.
  ///
  /// Options:
  /// - [ex]: Set the specified expire time, in seconds.
  /// - [px]: Set the specified expire time, in milliseconds.
  /// - [exAt]: Set the specified Unix time at which the key will expire,
  /// in seconds.
  /// - [pxAt]: Set the specified Unix time at which the key will expire,
  /// in milliseconds.
  /// - [persist]: Remove the time to live associated with the key.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [String]: The value of key.
  /// - [`null`]: If key does not exist.
  Future<String?> getEx(
    String key, {
    int? ex,
    int? px,
    int? exAt,
    int? pxAt,
    bool persist = false,
  }) async {
    final cmd = <String>['GETEX', key];
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
    } else if (persist) {
      cmd.add('PERSIST');
    }
    final result = await execute(cmd);
    return result as String?;
  }
}
