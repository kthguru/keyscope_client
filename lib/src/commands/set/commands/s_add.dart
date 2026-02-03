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

extension SAddCommand on SetCommands {
  /// SADD key member [member ...]
  ///
  /// Add the specified members to the set stored at key.
  /// Specified members that are already a member of this set are ignored.
  /// If key does not exist, a new set is created before adding
  /// the specified members.
  ///
  /// Complexity: O(1) for each element added, so O(N) to add N elements when
  /// the command is called with multiple arguments.
  ///
  /// Returns:
  /// - [int]: The number of elements that were added to the set, not including
  /// all the elements already present into the set.
  Future<int> sAdd(String key, List<String> members) async {
    final cmd = <String>['SADD', key, ...members];
    return executeInt(cmd);
  }
}
