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
  group('Generic Commands (Part 1: Basic & Expiration)', () {
    late KeyscopeClient client;

    setUp(() async {
      client = KeyscopeClient(host: 'localhost', port: 6379);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      await client.disconnect();
    });

    test('Keys Management: SET, GET, DEL, EXISTS, TYPE, KEYS', () async {
      // 1. Setup
      await client.set('k1', 'v1');
      await client.set('k2', 'v2');

      // 2. EXISTS
      expect(await client.exists(['k1']), equals(1));
      expect(await client.exists(['k1', 'k2', 'k3']), equals(2));

      // 3. TYPE
      expect(await client.type('k1'), equals('string'));

      // 4. KEYS
      final keys = await client.keys('k*');
      expect(keys, containsAll(['k1', 'k2']));

      // 5. DEL
      final deleted = await client.del(['k1']);
      expect(deleted, equals(1));
      expect(await client.exists(['k1']), equals(0));
    });

    test('Copy & Rename', () async {
      await client.set('src', 'value');

      // 1. COPY
      final copied = await client.copy('src', 'dest');
      expect(copied, isTrue);
      expect(await client.get('dest'), equals('value'));

      // 2. RENAME
      await client.rename('dest', 'dest_renamed');
      expect(await client.exists(['dest']), equals(0));
      expect(await client.get('dest_renamed'), equals('value'));

      // 3. RENAMENX
      // src exists, dest_renamed exists.
      final renamedNx = await client.renameNx('src', 'dest_renamed');
      expect(renamedNx, isFalse); // Should fail because dest_renamed exists
    });

    test('Expiration: EXPIRE, TTL, PERSIST', () async {
      await client.set('temp', 'data');

      // 1. TTL (No expiry)
      expect(await client.ttl('temp'), equals(-1));

      // 2. EXPIRE
      final setExpire = await client.expire('temp', 10);
      expect(setExpire, 1); // isTrue

      // 3. TTL (Has expiry)
      final ttl = await client.ttl('temp');
      expect(ttl, inInclusiveRange(1, 10));

      // 4. PERSIST
      final persisted = await client.persist('temp');
      expect(persisted, isTrue);
      expect(await client.ttl('temp'), equals(-1));
    });

    test('Precise Expiration: PEXPIRE, PTTL', () async {
      await client.set('ptemp', 'data');

      // Set 500ms
      await client.pExpire('ptemp', 500);

      final pttl = await client.pTtl('ptemp');
      expect(pttl, greaterThan(0));
      expect(pttl, lessThanOrEqualTo(500));

      // Wait a bit
      await Future<void>.delayed(const Duration(milliseconds: 600));
      expect(await client.exists(['ptemp']), equals(0));
    });
  });
}
