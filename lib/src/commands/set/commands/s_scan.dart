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

extension SScanCommand on SetCommands {
  /// SSCAN key cursor [MATCH pattern] [COUNT count]
  ///
  /// Iterates elements of Set types.
  ///
  /// Options:
  /// - [match]: Glob-style pattern to filter elements.
  /// - [count]: Hint for the amount of work to be done per call.
  ///
  /// Complexity: O(1) for every call. O(N) for a complete iteration.
  ///
  /// Returns:
  /// - [List<dynamic>]: A list containing two elements:
  ///   1. The next cursor (String).
  ///   2. A list of elements (`List<String>`).
  Future<List<dynamic>> sScan(
    String key,
    int cursor, {
    String? match,
    int? count,
  }) async {
    final cmd = <String>['SSCAN', key, cursor.toString()];
    if (match != null) {
      cmd.add('MATCH');
      cmd.add(match);
    }
    if (count != null) {
      cmd.add('COUNT');
      cmd.add(count.toString());
    }

    final result = await execute(cmd);
    // Result is [cursor, [elements...]]
    if (result is List && result.length == 2) {
      final nextCursor = result[0] as String;
      final elements = (result[1] as List).cast<String>();
      return [nextCursor, elements];
    }
    throw Exception('Unexpected SSCAN response format');
  }
}
