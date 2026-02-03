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

import '../commands.dart' show StringCommands;

extension DecrByCommand on StringCommands {
  /// DECRBY key decrement
  ///
  /// Decrements the number stored at [key] by [decrement].
  /// If the key does not exist, it is set to 0 before performing the operation.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [int]: The value of key after the decrement.
  Future<int> decrBy(String key, int decrement) async {
    final cmd = <String>['DECRBY', key, decrement.toString()];
    return executeInt(cmd);
  }
}
