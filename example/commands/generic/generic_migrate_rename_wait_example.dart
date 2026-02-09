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
  // Source Client (localhost:6379)
  final client = KeyscopeClient(host: 'localhost', port: 6379);
  await client.connect();
  await client.flushAll();

  print('--- 🚚 Generic Example: Migrate, RenameNX, Wait ---\n');

  // ==========================================
  // 1. RENAMENX (Rename only if new key does not exist)
  // ==========================================
  print('1. RENAMENX Example...');

  await client.set('key_a', 'value_a');
  await client.set('key_b', 'value_b'); // key_b already exists

  // Attempt to rename key_a -> key_b
  // Should fail because key_b exists
  final success1 = await client.renameNx('key_a', 'key_b');
  print('   Rename key_a -> key_b (exists): $success1'); // false

  // Delete key_b and try again
  await client.del(['key_b']);
  final success2 = await client.renameNx('key_a', 'key_b');
  print('   Rename key_a -> key_b (deleted): $success2'); // true

  final val = await client.get('key_b');
  print('   Value of key_b: $val');

  // ==========================================
  // 2. WAIT (Wait for replication)
  // ==========================================
  print('\n2. WAIT Example...');

  await client.set('critical_data', 'saved');

  // WAIT numreplicas timeout
  // Waits for 1 replica to acknowledge the write within 500ms.
  // Returns the number of replicas reached.
  final replicas = await client.wait(1, 500);
  print('   Replicas acknowledged: $replicas');

  // ==========================================
  // 3. MIGRATE (Move key to another instance)
  // ==========================================
  print('\n3. MIGRATE Example...');
  print('   (Requires a target Redis instance at localhost:6380)');

  const migKey = 'move_me';
  await client.set(migKey, 'I am moving!');

  try {
    // Attempt migration to localhost:6380
    final result = await client.migrate(
        '127.0.0.1', // Target Host
        6380, // Target Port
        migKey, // Key
        0, // Destination DB
        1000, // Timeout (ms)
        copy: false,
        replace: true);
    print('   Migration Result: $result');

    final exists = await client.exists([migKey]);
    print('   Exists in source after migrate? $exists (0 means moved)');
  } catch (e) {
    print('   Migration failed (Target 6380 might be down): $e');
  }

  await client.disconnect();
  print('\n--- Done ---');
}
