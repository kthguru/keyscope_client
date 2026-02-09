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
  group('Generic Commands (Additional Tests)', () {
    late KeyscopeClient client;

    setUp(() async {
      client = KeyscopeClient(host: 'localhost', port: 6379);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      await client.disconnect();
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

      // 2. EXPIRETIME
      // Should return the Unix timestamp we just set
      final expireTime = await client.expireTime(key);
      expect(expireTime, equals(targetSeconds));
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

      // 2. PEXPIRETIME
      // Should return the exact Unix timestamp in milliseconds
      final expireTime = await client.pExpireTime(key);

      // Allow small margin for clock skew/processing time
      expect(expireTime, closeTo(targetMs, 100));
    });

    test('Async Delete: UNLINK', () async {
      await client.set('k1', 'v1');
      await client.set('k2', 'v2');

      // UNLINK
      final unlinked = await client.unlink(['k1', 'k2', 'missing_key']);
      expect(unlinked, equals(2)); // Only existing keys count

      // Verify deletion
      expect(await client.exists(['k1', 'k2']), equals(0));
    });

    test('Access Time: TOUCH', () async {
      await client.set('t1', 'v1');
      await client.set('t2', 'v2');

      // TOUCH
      // Updates last access time, returns count of touched keys
      final touched = await client.touch(['t1', 't2', 't3']);
      expect(touched, equals(2));
    });
  });
}
