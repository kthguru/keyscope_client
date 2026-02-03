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

extension GetDelCommand on StringCommands {
  /// GETDEL key
  ///
  /// Get the value of [key] and delete the key.
  /// This command is similar to GET, except for the fact that it also deletes
  /// the key on success.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [String]: The value of key.
  /// - [`null`]: If key does not exist.
  Future<String?> getDel(String key) async {
    final cmd = <String>['GETDEL', key];
    final result = await execute(cmd);
    return result as String?;
  }
}
