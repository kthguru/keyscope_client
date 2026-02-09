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
  group('Generic Commands (Part 2: Advanced)', () {
    late KeyscopeClient client;

    setUp(() async {
      client = KeyscopeClient(host: 'localhost', port: 6379);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      await client.disconnect();
    });

    test('Serialization: DUMP, RESTORE', () async {
      const key = 'mykey';
      await client.set(key, 'hello world');

      // 1. DUMP
      final dumpData = await client.dump(key);
      // print(dumpData);

      expect(dumpData, isNotNull);
      expect(dumpData, isNotEmpty);

      // 2. RESTORE
      // Delete original to restore
      await client.del([key]);

      final restoreRes = await client.restore(key, 0, dumpData!);

      expect(restoreRes, equals('OK'));
      expect(await client.get(key), equals('hello world'));
    });

    test('Iteration: SCAN', () async {
      // Setup: Add 20 keys
      for (var i = 0; i < 20; i++) {
        await client.set('key:$i', 'val:$i');
      }

      // SCAN
      // Start cursor '0'
      final result = await client.scan('0', match: 'key:*', count: 100);

      final nextCursor = result[0] as String;
      final keys = result[1] as List<String>;

      // Since count is 100 and we have 20, it likely returns all in one go,
      // and cursor becomes '0' (finished).
      expect(nextCursor, isA<String>());
      expect(keys.length, equals(20));
      expect(keys, contains('key:0'));
      expect(keys, contains('key:19'));
    });

    test('Sorting: SORT, SORT_RO', () async {
      const listKey = 'mylist';
      // Add items: 3, 1, 2
      await client.rPush(listKey, ['3', '1', '2']);

      // 1. SORT (Default numeric, ASC)
      final sorted = await client.sort(listKey) as List;
      expect(sorted, equals(['1', '2', '3']));

      // 2. SORT DESC
      final sortedDesc = await client.sort(listKey, desc: true) as List;
      expect(sortedDesc, equals(['3', '2', '1']));

      // 3. SORT STORE
      final storedCount = await client.sort(listKey, store: 'sorted_list');
      expect(storedCount, equals(3));

      // Verify stored list
      final storedList = await client.lRange('sorted_list', 0, -1);
      expect(storedList, equals(['1', '2', '3']));
    });

    test('Inspection: OBJECT, RANDOMKEY', () async {
      await client.set('obj_key', 'value');

      // 1. OBJECT ENCODING
      final encoding = await client.objectEncoding('obj_key');
      expect(encoding, isNotNull); // e.g., 'embstr'

      // 2. OBJECT IDLETIME
      final idle = await client.objectIdleTime('obj_key');
      expect(idle, greaterThanOrEqualTo(0));

      // 3. OBJECT REFCOUNT
      final ref = await client.objectRefCount('obj_key');
      expect(ref, greaterThanOrEqualTo(1));

      // 4. RANDOMKEY
      final rand = await client.randomKey();
      expect(rand, equals('obj_key'));
    });

    test('Move: MOVE', () async {
      // Current DB is 0
      await client.set('move_me', 'data');

      // Move to DB 1
      final moved = await client.move('move_me', 1);
      // If DB 1 is available and empty/no conflict, it returns true.
      // Standard Redis config has 16 DBs.
      expect(moved, isTrue);

      // Verify gone from DB 0
      expect(await client.exists(['move_me']), equals(0));
    });

    test('Replication Wait: WAIT', () async {
      // Just check syntax, as standalone redis returns 0 replicas
      await client.set('k', 'v');
      final replicas = await client.wait(1, 100); // Wait 100ms
      expect(replicas, greaterThanOrEqualTo(0));
    });
  });
}
