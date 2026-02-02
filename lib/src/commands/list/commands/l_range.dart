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

extension LRangeCommand on ListCommands {
  /// LRANGE key start stop
  ///
  /// Returns the specified elements of the list stored at [key].
  /// The offsets [start] and [stop] are zero-based indexes.
  /// Negative offsets indicate offsets starting at the end of the list.
  ///
  /// Complexity: O(S+N) where S is the distance of start offset from
  /// HEAD for small lists,
  /// and from nearest end (HEAD or TAIL) for large lists; and N is
  /// the number of elements in the specified range.
  ///
  /// Returns:
  /// - List of elements in the specified range.
  Future<List<String>> lRange(String key, int start, int stop) async {
    final cmd = <String>['LRANGE', key, start.toString(), stop.toString()];
    final result = await execute(cmd);
    if (result is List) {
      return result.cast<String>();
    }
    return [];
  }
}
