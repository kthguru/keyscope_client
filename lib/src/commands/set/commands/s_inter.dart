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

extension SInterCommand on SetCommands {
  /// SINTER key [key ...]
  ///
  /// Returns the members of the set resulting from the intersection of
  /// all the given sets.
  /// Keys that do not exist are considered to be empty sets.
  ///
  /// Complexity: O(N*M) worst case where N is the cardinality of
  /// the smallest set and M is the number of sets.
  ///
  /// Returns:
  /// - [List<String>]: List with members of the resulting set.
  Future<List<String>> sInter(List<String> keys) async {
    final cmd = <String>['SINTER', ...keys];
    final result = await execute(cmd);
    return (result as List).cast<String>();
  }
}
