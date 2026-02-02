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

import '../commands.dart' show ListCommands;

extension BRPopLPushCommand on ListCommands {
  /// BRPOPLPUSH source destination timeout
  ///
  /// Atomically returns and removes the last element (tail) of the list stored
  /// at [source],
  /// and pushes the element at the first element (head) of the list stored at
  /// [destination].
  /// If the [source] list is empty, blocks until [timeout] is reached.
  ///
  /// [timeout] is in seconds. Use 0 to block indefinitely.
  ///
  /// Note: This command is deprecated in Redis 6.2.0, use BLMOVE instead.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - The element being popped and pushed.
  /// - [`null`] if the timeout is reached.
  Future<String?> bRPopLPush(
    String source,
    String destination,
    double timeout,
  ) async {
    final cmd = <String>['BRPOPLPUSH', source, destination, timeout.toString()];
    final result = await execute(cmd);
    return result as String?;
  }
}
