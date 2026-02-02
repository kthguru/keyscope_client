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

extension LInsertCommand on ListCommands {
  /// LINSERT key `<BEFORE | AFTER>` pivot element
  ///
  /// Inserts [element] in the list stored at [key] either before or after the
  /// reference value [pivot].
  ///
  /// [position] must be either 'BEFORE' or 'AFTER'.
  ///
  /// Complexity: O(N) where N is the number of elements to traverse before
  /// seeing the value pivot.
  ///
  /// Returns:
  /// - The length of the list after the insert operation.
  /// - -1 when the value pivot was not found.
  /// - 0 when the key does not exist.
  Future<int> lInsert(
    String key,
    String position,
    String pivot,
    String element,
  ) async {
    final cmd = <String>['LINSERT', key, position, pivot, element];
    return executeInt(cmd);
  }
}
