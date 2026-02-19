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
import 'package:test/test.dart';

void main() {
  group('Cuckoo Filter - Basic Lifecycle', () {
    late KeyscopeClient client;
    var isRedis = false;
    const port = 6379;

    setUpAll(() async {
      final tempClient = KeyscopeClient(host: 'localhost', port: port);
      try {
        await tempClient.connect();
        isRedis = await tempClient.isRedisServer();
      } catch (e) {
        print('Warning: Failed to check server type in setUpAll: $e');
      } finally {
        await tempClient.close();
      }
    });

    setUp(() async {
      client = KeyscopeClient(host: 'localhost', port: 6379);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      try {
        if (client.isConnected) {
          await client.disconnect();
        }
      } catch (_) {}
    });

    void testRedis(String description, Future<void> Function() body) {
      test(description, () async {
        if (!isRedis) {
          markTestSkipped('Skipping: This feature is supported on Redis only.');
          return;
        }
        await body();
      });
    }

    testRedis('Add, Exists, and Delete', () async {
      const key = 'cf:test';

      // 1. CF.ADD
      final added1 = await client.cfAdd(key, 'apple');
      expect(added1, isTrue);

      // 2. CF.EXISTS
      final existsApple = await client.cfExists(key, 'apple');
      expect(existsApple, isTrue);

      final existsBanana = await client.cfExists(key, 'banana');
      expect(existsBanana, isFalse);

      // 3. CF.DEL (Cuckoo Filter specific feature)
      final deleted = await client.cfDel(key, 'apple');
      expect(deleted, isTrue);

      final existsAfterDel = await client.cfExists(key, 'apple');
      expect(existsAfterDel, isFalse);
    });

    testRedis('INSERT, COUNT, and INFO', () async {
      const key = 'cf:info';

      // 1. CF.INSERTNX (Bulk insert preventing duplicates)
      final res = await client.cfInsertNx(key, ['item1', 'item2', 'item1']);
      // First item1: true, item2: true, second item1: false
      expect(res, equals([true, true, false]));

      // 2. CF.COUNT (Check number of occurrences)
      final count = await client.cfCount(key, 'item1');
      // Should be exactly 1 because of INSERTNX
      expect(count, equals(1));

      // 3. CF.INFO
      final info = await client.cfInfo(key);
      expect(info, isNotNull);
      expect(info.toString(), contains('Bucket size'));
    });
  });
}
