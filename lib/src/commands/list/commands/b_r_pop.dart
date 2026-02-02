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

extension BRPopCommand on ListCommands {
  /// BRPOP key [key ...] timeout
  ///
  /// Removes and returns the last element of the first non-empty list.
  /// If the lists are empty, blocks the connection until another client pushes
  /// to it or until [timeout] is reached.
  ///
  /// [timeout] is in seconds. Use 0 to block indefinitely.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - A two-element array: [key, element].
  /// - [`null`] if the timeout is reached.
  Future<List<String>?> bRPop(List<String> keys, double timeout) async {
    final cmd = <String>['BRPOP', ...keys, timeout.toString()];
    final result = await execute(cmd);
    if (result is List) {
      return result.cast<String>();
    }
    return null;
  }
}
