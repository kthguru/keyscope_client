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

extension MSetCommand on StringCommands {
  /// MSET key value [key value ...]
  ///
  /// Sets the given keys to their respective values.
  /// MSET replaces existing values with new values, just as regular SET.
  ///
  /// Complexity: O(N) where N is the number of keys to set.
  ///
  /// Returns:
  /// - 'OK'.
  Future<String> mSet(Map<String, String> data) async {
    final cmd = <String>['MSET'];
    data.forEach((key, value) {
      cmd.add(key);
      cmd.add(value);
    });
    return executeString(cmd);
  }
}
