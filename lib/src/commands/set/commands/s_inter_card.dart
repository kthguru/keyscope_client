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

extension SInterCardCommand on SetCommands {
  /// SINTERCARD numkeys key [key ...] [LIMIT limit]
  ///
  /// This command is similar to SINTER, but instead of returning
  /// the result set, it returns just the cardinality of the result.
  ///
  /// [limit]: If the intersection cardinality reaches this limit,
  /// the command returns the limit immediately.
  ///
  /// Complexity: O(N*M) worst case where N is the cardinality of
  /// the smallest set and M is the number of sets.
  ///
  /// Returns:
  /// - [int]: The cardinality of the intersection, or the limit if reached.
  Future<int> sInterCard(List<String> keys, {int? limit}) async {
    final cmd = <String>['SINTERCARD', keys.length.toString(), ...keys];
    if (limit != null) {
      cmd.add('LIMIT');
      cmd.add(limit.toString());
    }
    return executeInt(cmd);
  }
}
