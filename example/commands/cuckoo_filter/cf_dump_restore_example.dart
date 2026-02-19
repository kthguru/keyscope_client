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

  print('--- 💾 Cuckoo Filter Backup/Restore Example ---');

  const sourceKey = 'cf:live';
  const backupKey = 'cf:backup';

  await client.cfAdd(sourceKey, 'session_A');
  await client.cfAdd(sourceKey, 'session_B');

  print('1. Starting SCANDUMP...');
  var iterator = 0;
  final chunks = <Map<String, dynamic>>[];

  while (true) {
    final dump = await client.cfScanDump(sourceKey, iterator);
    if (dump.isEmpty) break;

    final nextIter = int.parse(dump[0].toString());
    final data = dump[1];

    if (nextIter == 0) break; // Safe exit condition

    chunks.add({'iter': nextIter, 'data': data});

    final size = data is List
        ? data.length
        : (data is String ? data.codeUnits.length : 0);
    print('   -> Dumped chunk (Iter: $nextIter, Size: $size bytes)');

    iterator = nextIter;
  }

  print('2. Restoring with LOADCHUNK...');
  for (final chunk in chunks) {
    await client.cfLoadChunk(
        backupKey, chunk['iter'] as int, chunk['data'] as Object);
  }

  print('3. Verifying backup...');
  print('   session_A in backup: '
      '${await client.cfExists(backupKey, 'session_A')}');

  await client.disconnect();
}
