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

extension LRemCommand on ListCommands {
  /// LREM key count element
  ///
  /// Removes the first [count] occurrences of [element] from the list stored
  /// at [key].
  /// - count > 0: Remove elements equal to element moving from head to tail.
  /// - count < 0: Remove elements equal to element moving from tail to head.
  /// - count = 0: Remove all elements equal to element.
  ///
  /// Complexity: O(N+M) where N is the length of the list and M is
  /// the number of removed elements.
  ///
  /// Returns:
  /// - The number of removed elements.
  Future<int> lRem(String key, int count, String element) async {
    final cmd = <String>['LREM', key, count.toString(), element];
    return executeInt(cmd);
  }
}
