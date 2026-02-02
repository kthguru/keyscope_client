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

extension BLMPopCommand on ListCommands {
  /// BLMPOP timeout numkeys key [key ...] `<LEFT | RIGHT>` [COUNT count]
  ///
  /// Pop elements from a list where [keys] are the list keys to pop from.
  /// It blocks the connection until there are elements to pop from any of the
  /// given lists.
  ///
  /// [timeout] is in seconds. A timeout of 0 can be used to block indefinitely.
  /// [direction] must be either 'LEFT' or 'RIGHT'.
  /// [count] is the number of elements to pop (optional).
  ///
  /// Complexity: O(N+M) where N is the number of provided keys and M is
  /// the number of elements returned.
  ///
  /// Returns:
  /// - A two-element array with the first element being the name of the key
  ///   from which elements were popped,
  ///   and the second element being an array of elements.
  /// - [`null`] when no element could be popped and the timeout expired.
  Future<dynamic> bLMPop(
    double timeout,
    List<String> keys,
    String direction, {
    int? count,
  }) async {
    final cmd = <String>[
      'BLMPOP',
      timeout.toString(),
      keys.length.toString(),
      ...keys,
      direction,
    ];
    if (count != null) {
      cmd.add('COUNT');
      cmd.add(count.toString());
    }
    return execute(cmd);
  }
}
