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

extension SubStrCommand on StringCommands {
  /// SUBSTR key start end
  ///
  /// Deprecated alias for GETRANGE.
  /// Returns the substring of the string value stored at [key], determined by
  /// the offsets [start] and [end].
  ///
  /// Complexity: O(N) where N is the length of the returned string.
  ///
  /// Returns:
  /// - [String]: The substring.
  Future<String> subStr(String key, int start, int end) async {
    final cmd = <String>['SUBSTR', key, start.toString(), end.toString()];
    return executeString(cmd);
  }
}
