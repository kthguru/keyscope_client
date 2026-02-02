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

extension LSetCommand on ListCommands {
  /// LSET key index element
  ///
  /// Sets the list element at [index] to [element].
  ///
  /// Complexity: O(N) where N is the length of the list.
  ///
  /// Returns:
  /// - 'OK'.
  Future<String> lSet(String key, int index, String element) async {
    final cmd = <String>['LSET', key, index.toString(), element];
    return executeString(cmd);
  }
}
