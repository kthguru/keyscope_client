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

  print('--- 🚀 Generic Advanced Example (Scan, Sort, Migrate) ---\n');

  // 1. SCAN (Safe Iteration)
  print('1. SCAN Iteration...');
  // Populate more data for scan
  for (var i = 0; i < 10; i++) {
    await client.set('user:$i', 'User $i');
  }

  var cursor = '0';
  do {
    // Scan matching 'user:*' with count hint 5
    final res = await client.scan(cursor, match: 'user:*', count: 5);
    cursor = res[0] as String;
    final keys = res[1] as List<String>;

    print('   Scanned batch: $keys');
  } while (cursor != '0');

  // 2. SORT (List sorting)
  print('\n2. SORT Operations...');
  const scoresKey = 'scores';
  await client.rPush(scoresKey, ['100', '50', '80', '10']);

  // Sort numeric ascending
  final sortedScores = await client.sort(scoresKey);
  print('   Sorted Scores (ASC): $sortedScores');

  // Sort and Store
  final count = await client.sort(scoresKey, desc: true, store: 'top_scores');
  print('   Stored $count items to "top_scores" (DESC).');

  // 3. Object Inspection
  print('\n3. Object Inspection...');
  final encoding = await client.objectEncoding(scoresKey);
  final idleTime = await client.objectIdleTime(scoresKey);
  print('   Key: $scoresKey');
  print('   - Encoding: $encoding');
  print('   - Idle Time: ${idleTime}s');

  // 4. Dump & Restore (Backup)
  print('\n4. Backup & Restore...');
  final dumpData = await client.dump('top_scores');
  if (dumpData != null) {
    print('   Dumped "top_scores" (${dumpData.length} bytes)');

    // Restore to a new key
    await client.restore('restored_scores', 0, dumpData);
    print('   Restored to "restored_scores".');
    print(
        '   Check restored: ${await client.lRange('restored_scores', 0, -1)}');
  }

  // 5. Move (Database Transfer)
  print('\n5. Moving Key to DB 1...');
  final moved = await client.move('restored_scores', 1);
  if (moved) {
    print('   Successfully moved "restored_scores" to DB 1.');
    print('   Exists in DB 0? ${await client.exists([
          'restored_scores'
        ])} (Should be 0)');
  } else {
    print('   Move failed (maybe target key exists or key missing).');
  }

  await client.disconnect();
  print('\n--- Done ---');
}
