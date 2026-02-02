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

import '../commands.dart' show ServerCommands;

extension FlushAllCommand on ServerCommands {
  /// FLUSHALL [ASYNC | SYNC]
  ///
  /// Delete all the keys of all the existing databases, not just the currently
  /// selected one.
  /// By default, FlushAll will synchronously flush all the databases.
  ///
  /// Options:
  /// - [async]: If true, the flush will be done asynchronously (non-blocking).
  ///
  /// Complexity: O(N) where N is the total number of keys in all databases.
  ///
  /// Returns:
  /// - 'OK'.
  Future<String> flushAll({bool async = false}) async {
    final cmd = <String>['FLUSHALL'];
    if (async) {
      cmd.add('ASYNC');
    }
    return executeString(cmd);
  }
}
