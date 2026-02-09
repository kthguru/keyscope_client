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

  print('--- 🔍 Generic Advanced Extra Example (Object, SortRo, Wait) ---\n');

  // Setup data
  await client.set('user:profile', '{"name":"Alice"}');
  await client.rPush('items', ['apple', 'banana', 'cherry']);

  // Setup data
  // await client.set('user:1', 'Alice');
  // await client.rPush('scores', ['100', '50', '80', '10']);

  // Object Inspection (Full Suite)

  // 1. OBJECT Commands (Inspection)
  print('1. Object Inspection...');

  // A. OBJECT ENCODING
  final encoding = await client.objectEncoding('user:profile');
  print('   [Encoding] user:profile: $encoding'); // e.g., embstr

  // B. OBJECT IDLETIME
  final idleTime = await client.objectIdleTime('user:profile');
  print('   [IdleTime] user:profile: ${idleTime}s');

  // C. OBJECT REFCOUNT
  final refCount = await client.objectRefCount('user:profile');
  print('   [RefCount] user:profile: $refCount');

  // D. OBJECT FREQ (Requires maxmemory-policy to be LFU)
  await objectFreqExample(client);

  // E. OBJECT HELP
  final helpObj = await client.objectHelp();
  if (helpObj.isNotEmpty) {
    print('   [Help] First line: ${helpObj.first}');
    //
    // [Help] First line: OBJECT <subcommand> [<arg> [value] [opt] ...].
    // Subcommands are:
  }

  // 2. RANDOMKEY
  print('\n2. Random Key...');
  // Returns a random key from the DB
  final randKey = await client.randomKey();
  print('   Randomly selected key: $randKey');

  // 3. SORT_RO (Read-Only Sort)
  print('\n3. Read-Only Sort (SORT_RO)...');
  // Safe to use in read-only replicas as it doesn't support STORE
  final sortedRo = await client.sortRo('items', alpha: true, desc: true);
  print('   Sorted items (DESC, Alpha): $sortedRo');

  // SORT_RO differs from SORT as it cannot store results,
  // safe for read-only replicas.
  // final sortedRo = await client.sortRo('scores');
  // print('   Sorted (RO): $sortedRo');

  // 4. Persistence Wait (WAITAOF)
  await waitAofExample(client);

  await client.disconnect();
  print('\n--- Done ---');
}

// KeyscopeServerException(ERR):
// ERR WAITAOF cannot be used when numlocal is set but appendonly is disabled.
Future<void> waitAofExample(KeyscopeClient client) async {
  // 4. Persistence Wait (WAITAOF)
  print('\n4. Waiting for AOF (WAITAOF)...');

  // [Setup] Get original configs

  // [Setup] Check current AOF configuration
  // This returns ['appendonly', 'no'] or ['appendonly', 'yes']
  final originalAof = await client.configGet('appendonly');
  // This returns ['appendfsync', 'everysec'] or ['appendonly', 'always']
  final originalFsync = await client.configGet('appendfsync');

  // Enable AOF if disabled (if it is currently disabled)
  if (originalAof == 'no') {
    print('   [Setup] Enabling "appendonly" temporarily for WAITAOF...');
    await client.configSet('appendonly', 'yes');

    // Give Redis a moment to initialize AOF file if needed
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  if (originalFsync != 'always') {
    // Set appendfsync to 'always' for immediate sync
    print('   [Setup] Setting "appendfsync" to "always"...');
    await client.configSet('appendfsync', 'always');
  }

  // Give Redis a moment
  await Future<void>.delayed(const Duration(milliseconds: 200));

  // Perform Write Operation
  //
  // Forces a flush to AOF on local and replicas
  await client.set('important:log', 'system_start');
  // await client.set('critical:data', 'must_persist');

  // Execute WAITAOF (numLocal=1, numReplicas=0, timeout=1000ms)
  try {
    final waitAofRes = await client.waitAof(1, 0, 1000);
    print(
        '   WAITAOF Result: Local=${waitAofRes[0]}, Replicas=${waitAofRes[1]}');
  } catch (e) {
    print('   WAITAOF Failed: $e');
  } finally {
    // [Teardown] Restore configs / Revert AOF configuration
    print('   [Teardown] Restoring configurations...');
    if (originalAof != null) {
      print('   [Teardown] Reverting "appendonly" to "$originalAof"...');
      await client.configSet('appendonly', originalAof); // no
    }
    if (originalFsync != null) {
      print('   [Teardown] Reverting "appendfsync" to "$originalFsync"...');
      await client.configSet('appendfsync', originalFsync); // everysec
    }

    // await Future.delayed(Duration(milliseconds: 2000));
  }
}

// KeyscopeServerException(ERR):
// ERR An LFU maxmemory policy is not selected, access frequency not tracked.
// Please note that when switching between policies at runtime LRU and
// LFU data will take some time to adjust.
Future<void> objectFreqExample(KeyscopeClient client) async {
  // D. OBJECT FREQ (Safely Switch Config)
  print('   [Freq] Preparing LFU environment...');

  // 1) Backup original policy
  final originalPolicy = await client.configGet('maxmemory-policy');
  // This returns ['maxmemory-policy', 'noeviction']
  // print(originalPolicy); // noeviction

  // 2) Set policy to 'allkeys-lfu' to enable frequency tracking
  final res = await client.configSet('maxmemory-policy', 'allkeys-lfu');
  print('${' ' * 2} $res'); // OK

  // Wrap in try-catch because Redis throws an error if not in LFU mode.
  try {
    // 3) Execute OBJECT FREQ
    // Access the key twice to ensure it has frequency data
    await client.mget(['user:profile', 'user:profile']);

    final freq = await client.objectFreq('user:profile');
    print('   [Freq] user:profile: $freq (LFU Mode Enabled)'); // 2 (= twice)
  } catch (e) {
    // Expected error if maxmemory-policy is not LFU (e.g., volatile-lru)
    print('   [Freq] user:profile: N/A (Requires LFU policy)');
  }

  // 4) Restore original policy
  final resCmd = await client.configSet('maxmemory-policy', originalPolicy!);
  print('${' ' * 2} $resCmd'); // OK
  print('   [Freq] Restored maxmemory-policy to "$originalPolicy"');
}
