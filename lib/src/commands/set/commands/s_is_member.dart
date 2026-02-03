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

extension SIsMemberCommand on SetCommands {
  /// SISMEMBER key member
  ///
  /// Returns if [member] is a member of the set stored at [key].
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [bool]: true if the element is a member of the set, false otherwise.
  Future<bool> sIsMember(String key, String member) async {
    final cmd = <String>['SISMEMBER', key, member];
    final result = await executeInt(cmd);
    return result == 1;
  }
}
