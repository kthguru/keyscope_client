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

import '../commands.dart';

extension MSetExCommand on StringCommands {
  /// MSETEX numkeys key value [key value ...] [NX | XX] [ EX seconds |
  /// PX milliseconds | EXAT unix-time-seconds | PXAT unix-time-milliseconds |
  /// KEEPTTL ]
  ///
  /// Atomically sets multiple string keys with an optional shared expiration
  /// in a single operation.
  ///
  /// Parameters:
  /// - [data]: A map of key-value pairs to set.
  /// - [nx]: Set only if none of the keys exist.
  /// - [xx]: Set only if all of the keys exist.
  /// - [ex]: Set expiration time in seconds.
  /// - [px]: Set expiration time in milliseconds.
  /// - [exAt]: Set expiration unix time in seconds.
  /// - [pxAt]: Set expiration unix time in milliseconds.
  /// - [keepTtl]: Retain the time to live associated with the keys.
  ///
  /// Complexity: O(N) where N is the number of keys to set.
  ///
  /// Returns:
  /// - [int]: 0 if none of the keys were set; 1 if all of the keys were set.
  Future<int> mSetEx(Map<String, String> data,
      {bool nx = false,
      bool xx = false,
      int? ex,
      int? px,
      int? exAt,
      int? pxAt,
      bool keepTtl = false,
      bool forceRun = false}) async {
    await checkValkeySupport('MSETEX', forceRun: forceRun);
    final cmd = <String>['MSETEX'];

    // 1. numkeys
    cmd.add(data.length.toString());

    // 2. key value pairs
    data.forEach((key, value) {
      cmd.add(key);
      cmd.add(value);
    });

    // 3. Options
    if (nx) cmd.add('NX');
    if (xx) cmd.add('XX');

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

    return executeInt(cmd);
  }
}
