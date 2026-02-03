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

extension SMIsMemberCommand on SetCommands {
  /// SMISMEMBER key member [member ...]
  ///
  /// Returns whether each member is a member of the set stored at [key].
  ///
  /// Complexity: O(N) where N is the number of elements being checked.
  ///
  /// Returns:
  /// - [List<int>]: List representing the membership of the given elements,
  /// in the same order as they are requested.
  ///   1 if the element is a member of the set.
  ///   0 if the element is not a member of the set, or if key does not exist.
  Future<List<int>> sMIsMember(String key, List<String> members) async {
    final cmd = <String>['SMISMEMBER', key, ...members];
    final result = await execute(cmd);
    return (result as List).cast<int>();
  }
}
