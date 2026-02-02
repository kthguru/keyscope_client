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

extension FlushDbCommand on ServerCommands {
  /// FLUSHDB [ASYNC | SYNC]
  ///
  /// Delete all the keys of the currently selected DB.
  /// By default, FlushDb will synchronously flush the database.
  ///
  /// Options:
  /// - [async]: If true, the flush will be done asynchronously (non-blocking).
  ///
  /// Complexity: O(N) where N is the number of keys in the database.
  ///
  /// Returns:
  /// - 'OK'.
  Future<String> flushDb({bool async = false}) async {
    final cmd = <String>['FLUSHDB'];
    if (async) {
      cmd.add('ASYNC');
    }
    return executeString(cmd);
  }
}
