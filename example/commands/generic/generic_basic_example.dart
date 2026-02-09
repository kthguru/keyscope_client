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

  print('--- 🔑 Generic Basic Example (Key Mgmt & Relative Expiry) ---\n');

  // Setup data
  await client.set('user:1', 'Alice');
  await client.set('user:2', 'Bob');
  await client.set('session:1', 'active');

  // 1. Basic Info (EXISTS, TYPE, KEYS)
  print('1. Key Information...');
  final existsCount = await client.exists(['user:1', 'user:2', 'unknown']);
  print('   Exists Count: $existsCount'); // 2

  final type = await client.type('user:1');
  print('   Type of user:1: $type'); // string

  final keys = await client.keys('user:*');
  print('   Keys matching "user:*": $keys');

  // 2. Manipulation (COPY, RENAME)
  print('\n2. Key Manipulation...');
  // Copy user:1 to user:1:backup
  await client.copy('user:1', 'user:1:backup');
  print('   Copied user:1 to user:1:backup');

  // Rename user:2 to user:new
  await client.rename('user:2', 'user:new');
  print('   Renamed user:2 to user:new');

  // 3. Relative Expiration (EXPIRE, TTL, PERSIST)
  print('\n3. Relative Expiration...');

  // Set expiry to 60 seconds
  await client.expire('session:1', 60);
  final ttl = await client.ttl('session:1');
  print('   TTL of session:1: $ttl seconds');

  // Remove expiry
  await client.persist('session:1');
  print('   Persisted session:1 (TTL: ${await client.ttl('session:1')})');

  // 4. Millisecond Precision (PEXPIRE, PTTL)
  print('\n4. Precision Expiration (Milliseconds)...');
  await client.pExpire('user:1:backup', 1500); // 1.5 seconds
  final pttl = await client.pTtl('user:1:backup');
  print('   PTTL of backup: $pttl ms');

  // 5. Synchronous Delete (DEL)
  await client.del(['user:new']);
  print('   Deleted user:new');

  await client.disconnect();
  print('\n--- Done ---');
}
