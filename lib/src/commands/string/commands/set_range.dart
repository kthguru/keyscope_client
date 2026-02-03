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

extension SetRangeCommand on StringCommands {
  /// SETRANGE key offset value
  ///
  /// Overwrites part of the string stored at [key], starting at
  /// the specified [offset], for the entire length of [value].
  /// If the offset is larger than the current length of the string at key,
  /// the string is padded with zero-bytes to make offset fit.
  ///
  /// Complexity: O(1), not counting the time taken to copy
  /// the new string in place.
  ///
  /// Returns:
  /// - [int]: The length of the string after it was modified by the command.
  Future<int> setRange(String key, int offset, String value) async {
    final cmd = <String>['SETRANGE', key, offset.toString(), value];
    return executeInt(cmd);
  }
}
