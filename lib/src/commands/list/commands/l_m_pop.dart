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

extension LMPopCommand on ListCommands {
  /// LMPOP numkeys key [key ...] `<LEFT | RIGHT>` [COUNT count]
  ///
  /// Pops one or more elements from the first non-empty list key from the
  /// provided [keys].
  ///
  /// [direction] must be either 'LEFT' or 'RIGHT'.
  /// [count] is the number of elements to pop (optional).
  ///
  /// Complexity: O(N+M) where N is the number of provided keys and M is
  /// the number of elements returned.
  ///
  /// Returns:
  /// - A two-element array: [key, elements].
  /// - [`null`] if no element could be popped.
  Future<dynamic> lMPop(
    List<String> keys,
    String direction, {
    int? count,
  }) async {
    final cmd = <String>[
      'LMPOP',
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
