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
  group('Bloom Filter - Basic Operations', () {
    late KeyscopeClient client;

    setUp(() async {
      client = KeyscopeClient(host: 'localhost', port: 6379);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      await client.disconnect();
    });

    test('ADD and EXISTS', () async {
      const key = 'bf:basic';

      // 1. BF.ADD
      final added = await client.bfAdd(key, 'apple');
      expect(added, isTrue);

      final addedAgain = await client.bfAdd(key, 'apple');
      expect(addedAgain, isFalse); // Already exists

      // 2. BF.EXISTS
      final exists = await client.bfExists(key, 'apple');
      expect(exists, isTrue);

      final notExists = await client.bfExists(key, 'banana');
      expect(notExists, isFalse);
    });

    test('MADD and MEXISTS', () async {
      const key = 'bf:multi';

      // 1. BF.MADD
      final maddRes = await client.bfMAdd(key, ['a', 'b', 'c']);
      expect(maddRes, equals([true, true, true]));

      final maddRes2 = await client.bfMAdd(key, ['a', 'd']);
      expect(maddRes2, equals([false, true])); // 'a' exists, 'd' new

      // 2. BF.MEXISTS
      final mexistsRes = await client.bfMExists(key, ['a', 'b', 'z']);
      expect(mexistsRes, equals([true, true, false]));
    });
  });
}
