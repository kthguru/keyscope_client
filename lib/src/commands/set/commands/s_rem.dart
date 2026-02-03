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

extension SRemCommand on SetCommands {
  /// SREM key member [member ...]
  ///
  /// Remove the specified members from the set stored at [key].
  /// Specified members that are not a member of this set are ignored.
  ///
  /// Complexity: O(N) where N is the number of members to be removed.
  ///
  /// Returns:
  /// - [int]: The number of members that were removed from the set,
  /// not including non existing members.
  Future<int> sRem(String key, List<String> members) async {
    final cmd = <String>['SREM', key, ...members];
    return executeInt(cmd);
  }
}
