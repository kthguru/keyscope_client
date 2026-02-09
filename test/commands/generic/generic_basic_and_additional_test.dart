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

    test('Keys Management: DEL, UNLINK, EXISTS, TOUCH, TYPE, KEYS', () async {
      // 1. Setup
      await client.set('k1', 'v1');
      await client.set('k2', 'v2');
      await client.set('k3', 'v3');

      // 2. EXISTS
      expect(await client.exists(['k1']), equals(1));
      expect(await client.exists(['k1', 'k2', 'k3']), equals(3));

      // 3. TOUCH
      // Updates last access time, returns count of touched keys
      final touched = await client.touch(['k1', 'k2', 'missing_key']);
      expect(touched, equals(2));

      // 4. TYPE
      expect(await client.type('k1'), equals('string'));

      // 5. KEYS
      final keys = await client.keys('k*');
      expect(keys, containsAll(['k1', 'k2', 'k3']));

      // 6. DEL (Synchronous Delete)
      final deleted = await client.del(['k1']);
      expect(deleted, equals(1));
      expect(await client.exists(['k1']), equals(0));

      // 7. UNLINK (Async Delete)
      final unlinked = await client.unlink(['k2', 'k3']);
      expect(unlinked, equals(2));
      expect(await client.exists(['k2', 'k3']), equals(0));
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

    test('Relative Expiration: EXPIRE, TTL, PERSIST', () async {
      await client.set('temp', 'data');

      // 1. TTL (No expiry)
      expect(await client.ttl('temp'), equals(-1));

      // 2. EXPIRE (10 seconds)
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

    test('Absolute Expiration: EXPIREAT, EXPIRETIME', () async {
      const key = 'abs_expire';
      await client.set(key, 'val');

      // Calculate timestamp: Now + 100 seconds
      final now = DateTime.now();
      final targetTime = now.add(const Duration(seconds: 100));
      final targetSeconds = targetTime.millisecondsSinceEpoch ~/ 1000;

      // 1. EXPIREAT
      final setAt = await client.expireAt(key, targetSeconds);
      expect(setAt, isTrue);

      // 2. EXPIRETIME (Redis 7.0+)
      // Should return the Unix timestamp we just set
      final expireTime = await client.expireTime(key);
      expect(expireTime, equals(targetSeconds));

      // 3. TTL Check
      final ttl = await client.ttl(key);
      expect(ttl, inInclusiveRange(90, 100));
    });

    test('Precise Relative Expiration: PEXPIRE, PTTL', () async {
      const key = 'ptemp';
      await client.set(key, 'data');

      // 1. PEXPIRE (500ms)
      await client.pExpire(key, 500);

      // 2. PTTL
      final pttl = await client.pTtl(key);
      expect(pttl, greaterThan(0));
      expect(pttl, lessThanOrEqualTo(500));

      // Wait a bit to verify expiry
      await Future<void>.delayed(const Duration(milliseconds: 600));
      expect(await client.exists([key]), equals(0));
    });

    test('Precise Absolute Expiration: PEXPIREAT, PEXPIRETIME', () async {
      const key = 'p_abs_expire';
      await client.set(key, 'val');

      // Calculate timestamp: Now + 2000ms
      final now = DateTime.now();
      final targetTime = now.add(const Duration(milliseconds: 2000));
      final targetMs = targetTime.millisecondsSinceEpoch;

      // 1. PEXPIREAT
      final setAt = await client.pExpireAt(key, targetMs);
      expect(setAt, isTrue);

      // 2. PEXPIRETIME (Redis 7.0+)
      // Should return the exact Unix timestamp in milliseconds
      final expireTime = await client.pExpireTime(key);

      // Allow very small margin of error (clock skew) but usually equal
      expect(expireTime, closeTo(targetMs, 10));

      // 3. PTTL Check
      final pttl = await client.pTtl(key);
      expect(pttl, inInclusiveRange(1000, 2000));
    });
  });
}
