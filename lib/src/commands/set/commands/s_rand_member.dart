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

extension SRandMemberCommand on SetCommands {
  /// SRANDMEMBER key [count]
  ///
  /// When called with just the [key] argument, return a random element from
  /// the set value stored at key.
  /// When called with the additional [count] argument, return an array of
  /// [count] distinct elements (if count > 0)
  /// or allowed duplicates (if count < 0).
  ///
  /// Complexity: O(1) without count, O(N) with count.
  ///
  /// Returns:
  /// - [String?]: The randomly selected element, or null when
  /// key does not exist (if count is not provided).
  /// - [List<String>]: List of elements (if count is provided).
  Future<dynamic> sRandMember(String key, [int? count]) async {
    final cmd = <String>['SRANDMEMBER', key];
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
