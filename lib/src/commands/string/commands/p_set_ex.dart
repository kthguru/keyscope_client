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

extension PSetExCommand on StringCommands {
  /// PSETEX key milliseconds value
  ///
  /// Set [key] to hold the string [value] and set [key] to timeout after
  /// a given number of [milliseconds].
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - 'OK'.
  Future<String> pSetEx(String key, int milliseconds, String value) async {
    final cmd = <String>['PSETEX', key, milliseconds.toString(), value];
    return executeString(cmd);
  }
}
