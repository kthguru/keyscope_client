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

extension RPopCommand on ListCommands {
  /// RPOP key [count]
  ///
  /// Removes and returns the last elements of the list stored at [key].
  /// By default, the command pops a single element from the end of the list.
  /// When [count] is provided, the command pops up to [count] elements.
  ///
  /// Complexity: O(N) where N is the number of elements returned.
  ///
  /// Returns:
  /// - The value of the last element (String) if [count] is not provided.
  /// - List of popped elements (`List<String>`) if [count] is provided.
  /// - [`null`] if key does not exist.
  Future<dynamic> rPop(String key, {int? count}) async {
    final cmd = <String>['RPOP', key];
    if (count != null) {
      cmd.add(count.toString());
    }
    return execute(cmd);
  }
}
