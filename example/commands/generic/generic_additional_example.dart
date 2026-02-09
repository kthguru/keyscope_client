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

  print('--- ⏰ Generic Additional Example (Absolute Expiry & Async) ---\n');

  // Setup data
  await client.set('event:new_year', '2025');
  await client.set('cache:image', 'binary_data');
  await client.set('page:home', '<html>...</html>');

  // 1. Absolute Expiration (EXPIREAT, EXPIRETIME)
  print('1. Absolute Expiration (Seconds)...');

  // Calculate specific Unix timestamp (e.g., 1 hour from now)
  final now = DateTime.now();
  final targetTime = now.add(const Duration(hours: 1));
  final targetSeconds = targetTime.millisecondsSinceEpoch ~/ 1000;

  // Set expiry to that specific timestamp
  await client.expireAt('event:new_year', targetSeconds);

  // Retrieve the absolute expiration timestamp
  final expireTime = await client.expireTime('event:new_year');
  print('   Current Time (Unix): ${now.millisecondsSinceEpoch ~/ 1000}');
  print('   Expire At (Unix):    $expireTime');
  print(
      '   Difference:          '
      '${expireTime - (now.millisecondsSinceEpoch ~/ 1000)}s');

  // 2. Precise Absolute Expiration (PEXPIREAT, PEXPIRETIME)
  print('\n2. Precise Absolute Expiration (Milliseconds)...');

  // Target: 500ms from now
  final targetMsTime = now.add(const Duration(milliseconds: 500));
  final targetMs = targetMsTime.millisecondsSinceEpoch;

  await client.pExpireAt('cache:image', targetMs);

  final pExpireTime = await client.pExpireTime('cache:image');
  print('   Expire At (Unix ms): $pExpireTime');

  // 3. Async Delete (UNLINK)
  print('\n3. Async Delete (UNLINK)...');
  // UNLINK is non-blocking, ideal for large keys
  final unlinkedCount = await client.unlink(['event:new_year', 'cache:image']);
  print('   Unlinked $unlinkedCount keys (Non-blocking delete)');

  // 4. Access Time Update (TOUCH)
  print('\n4. Updating Access Time (TOUCH)...');
  // Updates the LRU/LFU bits of the key without reading it
  final touchedCount = await client.touch(['page:home']);
  print('   Touched $touchedCount keys (Last access time updated)');

  await client.disconnect();
  print('\n--- Done ---');
}
