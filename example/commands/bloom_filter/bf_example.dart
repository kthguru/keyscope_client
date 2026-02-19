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
  await client.flushAll();

  print('--- 🌸 Bloom Filter Example ---');

  const key = 'filter:users';

  // 1. BF.RESERVE (Optional but recommended for performance tuning)
  print('1. Reserving Bloom Filter...');
  // 0.1% error rate, 1000 items capacity
  await client.bfReserve(key, 0.001, 1000);

  // 2. BF.ADD & BF.MADD
  print('2. Adding items...');
  await client.bfAdd(key, 'user:1');
  await client.bfMAdd(key, ['user:2', 'user:3', 'user:4']);
  print('   Added user:1, user:2, user:3, user:4');

  // 3. BF.EXISTS & BF.MEXISTS
  print('3. Checking existence...');
  final exists1 = await client.bfExists(key, 'user:1');
  print('   Does user:1 exist? $exists1'); // true

  final exists99 = await client.bfExists(key, 'user:99');
  print('   Does user:99 exist? $exists99'); // false (probably)

  final mExists = await client.bfMExists(key, ['user:2', 'user:99']);
  print('   Multi-check (user:2, user:99): $mExists'); // [true, false]

  // 4. BF.INFO
  print('4. Inspecting Filter Info...');
  final info = await client.bfInfo(key);
  print('   Info: $info');

  await client.disconnect();
  print('--- Done ---');
}
