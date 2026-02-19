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

  print('--- 🐦 Cuckoo Filter Example ---');

  const key = 'cuckoo:users';

  // 1. CF.RESERVE
  print('1. Reserving Cuckoo Filter...');
  await client.cfReserve(key, 1000, bucketSize: 2, maxIterations: 20);

  // 2. CF.ADD & CF.INSERT
  print('2. Adding items...');
  await client.cfAdd(key, 'alice');
  await client.cfInsert(key, ['bob', 'charlie']);
  print('   Added alice, bob, charlie.');

  // 3. CF.EXISTS
  print('3. Checking items...');
  print('   Does alice exist? ${await client.cfExists(key, 'alice')}');
  print('   Does dave exist? ${await client.cfExists(key, 'dave')}');

  // 4. CF.DEL (Cuckoo Filter's special power)
  print('4. Deleting an item...');
  final deleted = await client.cfDel(key, 'alice');
  print('   Deleted alice? $deleted');
  print('   Does alice exist now? ${await client.cfExists(key, 'alice')}');

  // 5. CF.INFO
  print('5. Info:');
  print('   ${await client.cfInfo(key)}');

  await client.disconnect();
}
