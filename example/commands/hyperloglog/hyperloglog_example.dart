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

import 'package:typeredis/typeredis.dart';

Future<void> main() async {
  // Initialize TypeRedis client
  final client = TRClient(host: 'localhost', port: 6379);
  await client.connect();
  await client.flushAll();

  print('--- 📊 TypeRedis HyperLogLog Example ---\n');

  // Scenario: Tracking Unique Website Visitors
  // HLL is perfect for this because it uses constant small memory (~12kb)
  // regardless of how many users (millions/billions) are added.

  print('1. Tracking visitors for Page A and Page B...');

  // Page A visitors
  await client.pfAdd('page:a:visitors', ['user1', 'user2', 'user3', 'user4']);

  // Page B visitors (user1 and user5 visited)
  await client.pfAdd('page:b:visitors', ['user1', 'user5']);

  // Get approx counts
  final countA = await client.pfCount(['page:a:visitors']);
  final countB = await client.pfCount(['page:b:visitors']);

  print('   Page A Unique Visitors: $countA'); // 4
  print('   Page B Unique Visitors: $countB'); // 2

  // Scenario: Total Unique Visitors across the entire site
  print('\n2. Calculating Total Unique Visitors (Union)...');

  // Method 1: PFCOUNT with multiple keys (Temporary Union)
  final unionCount =
      await client.pfCount(['page:a:visitors', 'page:b:visitors']);
  print('   Total Unique (A U B): '
      '$unionCount'); // 5 (user1 is not double counted)

  // Method 2: PFMERGE (Store Union result)
  await client
      .pfMerge('site:total:visitors', ['page:a:visitors', 'page:b:visitors']);
  final storedTotal = await client.pfCount(['site:total:visitors']);
  print('   Stored Total Visitors: $storedTotal');

  // Debugging (Internal usage)
  print('\n3. Debugging...');
  final encoding = await client.pfDebug('ENCODING', 'site:total:visitors');
  print('   HLL Encoding: $encoding');

  await client.close(); // disconnect
  print('\n--- Done ---');
}
