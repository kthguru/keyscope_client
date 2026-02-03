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

extension MSetNxCommand on StringCommands {
  /// MSETNX key value [key value ...]
  ///
  /// Sets the given keys to their respective values.
  /// MSETNX will not perform any operation at all even if
  /// just a single key already exists.
  ///
  /// Complexity: O(N) where N is the number of keys to set.
  ///
  /// Returns:
  /// - [int]: 1 if all the keys were set, 0 if no key was set
  /// (at least one key already existed).
  Future<int> mSetNx(Map<String, String> data) async {
    final cmd = <String>['MSETNX'];
    data.forEach((key, value) {
      cmd.add(key);
      cmd.add(value);
    });
    return executeInt(cmd);
  }
}
