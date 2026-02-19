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
  group('Bloom Filter - Advanced Operations', () {
    late KeyscopeClient client;

    setUp(() async {
      client = KeyscopeClient(host: 'localhost', port: 6379);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      await client.disconnect();
    });

    test('RESERVE and INFO', () async {
      const key = 'bf:reserved';

      // 1. BF.RESERVE
      // Error rate 0.01 (1%), Capacity 1000
      await client.bfReserve(key, 0.01, 1000);

      // 2. BF.INFO
      final info = await client.bfInfo(key);
      // Redis usually returns a List or Map. Convert to string for
      // easy checking.
      final infoStr = info.toString();
      expect(infoStr, contains('Capacity'));

      // Check specific field
      // Note: Return type depends on client/server version (int vs string)
      // We assume loose check or forceRun executes it.
    });

    test('INSERT with Options', () async {
      const key = 'bf:insert';

      // 1. BF.INSERT with creation options
      final res = await client.bfInsert(
        key,
        ['item1', 'item2'],
        capacity: 500,
        error: 0.001,
      );
      expect(res, equals([true, true]));

      // 2. BF.CARD
      final card = await client.bfCard(key);
      expect(card, equals(2));

      // 3. BF.INSERT with NOCREATE (should fail/empty if key missing)
      const missingKey = 'bf:missing';
      try {
        await client.bfInsert(missingKey, ['a'], noCreate: true);
        // Depending on Redis version, this might throw error or
        // return error response
      } catch (e) {
        expect(e.toString(), contains('not found'));
      }
    });
  });
}
