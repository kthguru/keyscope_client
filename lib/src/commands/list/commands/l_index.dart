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

extension LIndexCommand on ListCommands {
  /// LINDEX key index
  ///
  /// Returns the element at [index] in the list stored at [key].
  /// The index is zero-based, so 0 is the first element, 1 is the second,
  /// and so on.
  /// Negative indices can be used to designate elements starting at the tail of
  /// the list.
  ///
  /// Complexity: O(N) where N is the number of elements to traverse to reach
  /// the element at index.
  ///
  /// Returns:
  /// - The requested element.
  /// - [`null`] if the value at key is not a list or if the index is out of
  /// range.
  Future<String?> lIndex(String key, int index) async {
    final cmd = <String>['LINDEX', key, index.toString()];
    final result = await execute(cmd);
    return result as String?;
  }
}
