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

extension SMembersCommand on SetCommands {
  /// SMEMBERS key
  ///
  /// Returns all the members of the set value stored at [key].
  ///
  /// Complexity: O(N) where N is the set cardinality.
  ///
  /// Returns:
  /// - [List<String>]: All elements of the set.
  Future<List<String>> sMembers(String key) async {
    final cmd = <String>['SMEMBERS', key];
    final result = await execute(cmd);
    return (result as List).cast<String>();
  }
}
