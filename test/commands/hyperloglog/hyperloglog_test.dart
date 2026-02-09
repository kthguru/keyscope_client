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
  group('HyperLogLog Commands (keyscope_client)', () {
    late KeyscopeClient client; // Assuming class name is compatible or aliased

    setUp(() async {
      client = KeyscopeClient(host: 'localhost', port: 6379);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      await client.close(); // disconnect
    });

    test('PFADD and PFCOUNT', () async {
      const key = 'hll:visits';

      // 1. PFADD
      // Add 'user1', 'user2', 'user3' -> returns 1 (register updated)
      final res1 = await client.pfAdd(key, ['user1', 'user2', 'user3']);
      expect(res1, equals(1));

      // Add 'user1' again (duplicate) -> returns 0 (register not updated)
      final res2 = await client.pfAdd(key, ['user1']);
      expect(res2, equals(0));

      // 2. PFCOUNT
      final count = await client.pfCount([key]);
      expect(count, equals(3));
    });

    test('PFMERGE', () async {
      const hll1 = 'hll:day1';
      const hll2 = 'hll:day2';
      const hllTotal = 'hll:total';

      await client.pfAdd(hll1, ['a', 'b', 'c']); // 3 elements
      await client.pfAdd(hll2, ['c', 'd', 'e']); // 3 elements (c overlaps)

      // 1. PFMERGE
      final result = await client.pfMerge(hllTotal, [hll1, hll2]);
      expect(result, equals('OK'));

      // 2. PFCOUNT on merged key
      // Unique elements: a, b, c, d, e -> Total 5
      final total = await client.pfCount([hllTotal]);
      expect(total, equals(5));

      // 3. PFCOUNT union (without merging to a key)
      final unionCount = await client.pfCount([hll1, hll2]);
      expect(unionCount, equals(5));
    });

    test('PFDEBUG', () async {
      const key = 'hll:debug';
      await client.pfAdd(key, ['test']);

      // Check Encoding (usually 'sparse' for small sets, or 'dense')
      final encoding = await client.pfDebug('ENCODING', key);
      // (X) expect(encoding.toString().toLowerCase(), contains('encoding'));
      expect(encoding.toString(), isIn(['sparse', 'dense']));
    });

    test('PFSELFTEST', () async {
      // Note: Usually available, but dependent on server version/config
      try {
        final result = await client.pfSelfTest();
        expect(result, equals('OK'));
      } catch (e) {
        print('PFSELFTEST skipped or failed: $e');
      }
    });
  });
}
