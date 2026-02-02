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

extension RPushCommand on ListCommands {
  /// RPUSH key element [element ...]
  ///
  /// Insert all the specified [elements] at the tail of the list stored at
  /// [key].
  ///
  /// Complexity: O(N) where N is the number of elements to be pushed.
  ///
  /// Returns:
  /// - The length of the list after the push operation.
  Future<int> rPush(String key, List<String> elements) async {
    final cmd = <String>['RPUSH', key, ...elements];
    return executeInt(cmd);
  }
}
