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

import '../commands.dart' show StringCommands;

extension SetNxCommand on StringCommands {
  /// SETNX key value
  ///
  /// Set [key] to hold string [value] if [key] does not exist.
  /// In that case, it is equal to SET. When [key] already holds a value,
  /// no operation is performed.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [int]: 1 if the key was set, 0 if the key was not set.
  Future<int> setNx(String key, String value) async {
    final cmd = <String>['SETNX', key, value];
    return executeInt(cmd);
  }
}
