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

extension MGetCommand on StringCommands {
  /// MGET key [key ...]
  ///
  /// Returns the values of all specified keys.
  /// For every key that does not hold a string value or does not exist,
  /// the special value nil is returned.
  ///
  /// Complexity: O(N) where N is the number of keys to retrieve.
  ///
  /// Returns:
  /// - [List<String?>]: List of values at the specified keys.
  Future<List<String?>> mGet(List<String> keys) async {
    final cmd = <String>['MGET', ...keys];
    final result = await execute(cmd);
    if (result is List) {
      return result.cast<String?>();
    }
    return [];
  }
}
