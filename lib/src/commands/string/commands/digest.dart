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

extension DigestCommand on StringCommands {
  /// DIGEST key
  ///
  /// Get the hash digest for the value stored in the specified key as
  /// a hexadecimal string.
  /// Keys must be of type string.
  ///
  /// Computes and returns a digest (hash) of the value stored at [key].
  /// This is often used to verify data integrity without transferring
  /// the entire value.
  ///
  /// Complexity: O(N) where N is the length of the string value.
  ///
  /// Returns:
  /// - [String]: The hexadecimal digest string
  ///             (e.g., SHA-1 or similar hex representation).
  /// - [`null`]: If the key does not exist.
  Future<String?> digest(String key, {bool forceRun = false}) async {
    await checkValkeySupport('DIGEST', forceRun: forceRun);
    final cmd = <String>['DIGEST', key];
    final result = await execute(cmd);
    return result as String?;
  }
}
