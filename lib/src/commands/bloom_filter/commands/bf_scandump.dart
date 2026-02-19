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

import '../commands.dart' show BloomFilterCommands, ServerVersionCheck;

extension BfScandumpCommand on BloomFilterCommands {
  /// BF.SCANDUMP key iterator
  ///
  /// Begins an incremental save of the bloom filter.
  /// Returns a List where the first element is the next iterator (int)
  /// and the second element is the data chunk (List of bytes/strings).
  /// If the iterator returned is 0, the iteration is complete.
  ///
  /// [key]: The name of the filter.
  /// [iterator]: Iterator value; set to 0 for the first call.
  /// [forceRun]: Force execution on Valkey.
  Future<List<dynamic>> bfScandump(
    String key,
    int iterator, {
    bool forceRun = false,
  }) async {
    await checkValkeySupport('BF.SCANDUMP', forceRun: forceRun);

    final result = await execute(['BF.SCANDUMP', key, iterator]);
    if (result is List) {
      return result;
    }
    return [];
  }
}
