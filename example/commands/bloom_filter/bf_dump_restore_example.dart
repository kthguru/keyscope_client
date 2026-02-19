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

// import 'dart:typed_data';

import 'package:keyscope_client/keyscope_client.dart';

Future<void> main() async {
  final client = KeyscopeClient(host: 'localhost', port: 6379);
  await client.connect();

  // Redis Only Feature
  if (!await client.isRedis) {
    print('⚠️  Skipping: This example requires a Redis server.');
    print('   Current server appears to be Valkey or other compatible server.');
    await client.close(); // disconnect
    return;
  }

  await client.flushAll();

  print('--- 💾 Bloom Filter: Backup and Restore Example ---');

  const sourceKey = 'filter:production';
  const backupKey = 'filter:backup';

  // 1. Prepare Data
  print('1. Adding items to source filter...');
  await client.bfMAdd(sourceKey, ['apple', 'banana', 'cherry']);

  // 2. Perform SCANDUMP (Backup)
  print('2. Starting BF.SCANDUMP...');
  var iterator = 0;
  final backupChunks = <Map<String, dynamic>>[];

  while (true) {
    final dump = await client.bfScandump(sourceKey, iterator);

    if (dump.isEmpty) break;

    final nextIter = int.parse(dump[0].toString());
    final data = dump[1]; // Raw binary object

    // Stop loop if nextIter is 0. Do NOT save this chunk.
    if (nextIter == 0) {
      break;
    }

    // Keep raw data intact to prevent binary corruption
    backupChunks.add({'iter': nextIter, 'data': data});

    // Type Promotion
    int getSize(dynamic data) {
      var chunkSizeBytes = 0;
      if (data is List) {
        chunkSizeBytes = data.length;
      } else if (data is String) {
        chunkSizeBytes = data.codeUnits.length;
      }
      return chunkSizeBytes;
    }

    print('   -> Dumped chunk (Iterator: $nextIter, '
        'Size: ${getSize(data)} bytes)');

    iterator = nextIter;
  }
  print('   Backup complete. Total chunks: ${backupChunks.length}');

  // 3. Perform Restore (LOADCHUNK)
  print('3. Restoring data to backup key...');
  for (final chunk in backupChunks) {
    // For Redis, use bfLoadChunk. For Valkey, you would use bfLoad.
    // if (await client.isRedis || await client.isDragonfly) {
    await client.bfLoadChunk(
      backupKey,
      chunk['iter'] as int, // Provide the returned chunk identifier
      chunk['data'] as Object, // Raw object. Send exact raw data.
    );
    // } else if (await client.isValkey) {
    //   await client.bfLoad(
    //     backupKey,
    //     chunk['iter'] as int,
    //     chunk['data'] as Object,
    //   );
    // }
  }
  print('   Restore complete.');

  // 4. Verify
  print('4. Verifying restored data...');
  final exists = await client.bfExists(backupKey, 'banana');
  print('   Does "banana" exist in restored filter? $exists');

  await client.disconnect();
  print('--- Done ---');
}
