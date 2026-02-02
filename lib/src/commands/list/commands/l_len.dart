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

import '../commands.dart' show ListCommands;

extension LLenCommand on ListCommands {
  /// LLEN key
  ///
  /// Returns the length of the list stored at [key].
  /// If [key] does not exist, it is interpreted as an empty list and 0 is
  /// returned.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - The length of the list at key.
  Future<int> lLen(String key) async {
    final cmd = <String>['LLEN', key];
    return executeInt(cmd);
  }
}
