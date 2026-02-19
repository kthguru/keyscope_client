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

extension BfLoadChunkCommand on BloomFilterCommands {
  /// BF.LOADCHUNK key iterator data
  ///
  /// Restores a filter previously saved using BF.SCANDUMP.
  ///
  /// [key]: Name of the key to restore to.
  /// [iterator]: Iterator value associated with the data chunk.
  /// [data]: The raw data chunk returned by SCANDUMP. (Must not be modified)
  /// [forceRun]: Force execution on Valkey.
  Future<dynamic> bfLoadChunk(
    String key,
    int iterator,
    Object
        data, // Changed from List<int> to Object to prevent binary corruption
    {
    bool forceRun = false,
  }) async {
    await checkValkeySupport('BF.LOADCHUNK', forceRun: forceRun);

    return execute(['BF.LOADCHUNK', key, iterator, data]);
  }
}
