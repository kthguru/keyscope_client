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

import '../commands.dart';

extension SPopCommand on SetCommands {
  /// SPOP key [count]
  ///
  /// Removes and returns one or more random members from the set value store at
  ///  [key].
  ///
  /// [count]: If provided, returns an array of distinct elements.
  ///
  /// Complexity: O(1) without count, O(N) with count.
  ///
  /// Returns:
  /// - [String?]: The removed member, or null when key does not exist
  /// (if count is not provided).
  /// - [List<String>]: List of removed members (if count is provided).
  Future<dynamic> sPop(String key, [int? count]) async {
    final cmd = <String>['SPOP', key];
    if (count != null) {
      cmd.add(count.toString());
      final result = await execute(cmd);
      return (result as List).cast<String>();
    } else {
      final result = await execute(cmd);
      return result as String?;
    }
  }
}
