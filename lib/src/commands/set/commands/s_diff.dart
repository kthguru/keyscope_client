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

extension SDiffCommand on SetCommands {
  /// SDIFF key [key ...]
  ///
  /// Returns the members of the set resulting from the difference between
  /// the first set and all the successive sets.
  /// Keys that do not exist are considered to be empty sets.
  ///
  /// Complexity: O(N) where N is the total number of elements in
  /// all given sets.
  ///
  /// Returns:
  /// - [List<String>]: List with members of the resulting set.
  Future<List<String>> sDiff(String key,
      [List<String> otherKeys = const []]) async {
    final cmd = <String>['SDIFF', key, ...otherKeys];
    final result = await execute(cmd);
    return (result as List).cast<String>();
  }
}
