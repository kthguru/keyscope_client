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

extension AppendCommand on StringCommands {
  /// APPEND key value
  ///
  /// If [key] already exists and is a string, this command appends the
  /// [value] at the end of the string.
  /// If [key] does not exist it is created and set as an empty string,
  /// so APPEND will be similar to SET in this special case.
  ///
  /// Complexity: O(1). The amortized time complexity is O(1) assuming
  /// the appended value is small and the already present value is any size.
  ///
  /// Returns:
  /// - [int]: The length of the string after the append operation.
  Future<int> append(String key, String value) async {
    final cmd = <String>['APPEND', key, value];
    return executeInt(cmd);
  }
}
