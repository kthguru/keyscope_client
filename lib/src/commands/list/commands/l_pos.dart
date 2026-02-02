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

extension LPosCommand on ListCommands {
  /// LPOS key element [RANK rank] [COUNT num-matches] [MAXLEN len]
  ///
  /// Return the index of matching [element] inside the list stored at [key].
  ///
  /// Options:
  /// - [rank]: Position of the match to return (e.g., 1 for first match,
  ///           2 for second).
  ///   Negative rank searches from the end.
  /// - [count]: Number of matches to return. If present, returns a list of
  ///            indices.
  /// - [maxLen]: Limits the number of comparisons.
  ///
  /// Complexity: O(N) where N is the number of elements in the list.
  ///
  /// Returns:
  /// - The integer representing the matching element.
  /// - If [count] is given, returns a list of integers.
  /// - [`null`] if no match is found.
  Future<dynamic> lPos(
    String key,
    String element, {
    int? rank,
    int? count,
    int? maxLen,
  }) async {
    final cmd = <String>['LPOS', key, element];
    if (rank != null) {
      cmd.add('RANK');
      cmd.add(rank.toString());
    }
    if (count != null) {
      cmd.add('COUNT');
      cmd.add(count.toString());
    }
    if (maxLen != null) {
      cmd.add('MAXLEN');
      cmd.add(maxLen.toString());
    }
    return execute(cmd);
  }
}
