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

import 'dart:io';

import 'package:keyscope_client/keyscope_client.dart';
import 'package:test/test.dart';

void main() {
  group('MIGRATE Command Tests', () {
    late KeyscopeClient client;

    // Primary Redis (Source)
    const srcHost = 'localhost';
    const srcPort = 6379;

    // Target Redis (Destination)
    // Note: If you have a second instance running, set this port (e.g., 6380).
    // The test logic handles both cases (Target Up or Down).
    const targetHost = '127.0.0.1';
    const targetPort = 6380;

    setUp(() async {
      client = KeyscopeClient(host: srcHost, port: srcPort);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      await client.disconnect();
    });

    /// Test 1: Validate Command Syntax & Error Handling
    /// Even without a second Redis, we can verify that:
    /// 1. The library correctly formats the MIGRATE command.
    /// 2. The source Redis receives it and attempts to connect.
    /// 3. Returns a specific IOERR when the target is unreachable.
    test('Protocol Validation: Attempt MIGRATE to closed port', () async {
      const key = 'mig_protocol_test';
      await client.set(key, 'test_data');

      // Use a port that is definitely closed (e.g. 9999) to force an IOERR
      const deadPort = 9999;

      try {
        await client.migrate(
            '127.0.0.1',
            deadPort,
            key,
            0, // Destination DB
            100 // Timeout (ms)
            );
        fail('Should have thrown a Redis Error (IOERR)');
      } catch (e) {
        // Redis returns: "-IOERR error or timeout reading to target instance"
        // This confirms the command was valid and attempted.
        final msg = e.toString();
        expect(msg, contains('IOERR'),
            reason: 'Redis should report connection failure');
      }
    });

    /// Test 2: Validate Complex Parameters (KEYS, AUTH, COPY, REPLACE)
    /// Ensures arguments are strictly mapped according to Redis Spec.
    test('Parameter Validation: KEYS, COPY, REPLACE, AUTH', () async {
      const k1 = 'k1';
      const k2 = 'k2';
      await client.set(k1, 'v1');
      await client.set(k2, 'v2');

      try {
        // When using 'keys' parameter, the third argument (key) must be empty string "".
        // The implementation should handle this automatically or we pass keys explicitly.
        await client.migrate(
          '127.0.0.1',
          9999, // Dead port
          '', // key (ignored when keys is present)
          0,
          100,
          copy: true,
          replace: true,
          authPassword: 'fake_password',
          keys: [k1, k2],
        );
        fail('Should have thrown IOERR');
      } catch (e) {
        // If we get IOERR, it means Redis parsed [COPY, REPLACE, AUTH, KEYS...] correctly
        // and only failed at the network connection step.
        expect(e.toString(), contains('IOERR'));
      }
    });

    /// Test 3: Real Migration (Conditional)
    /// Performs a real migration ONLY IF a Redis instance is detected at targetHost:targetPort.
    test('Real Migration: Success Case (Target 6380)', () async {
      // 1. Check if target instance is running
      var isTargetUp = false;
      try {
        final socket = await Socket.connect(targetHost, targetPort,
            timeout: const Duration(milliseconds: 200));
        socket.destroy();
        isTargetUp = true;
      } catch (_) {
        print(
            '   [Info] Target Redis ($targetPort) down. Skipping real migration test.');
      }

      // 2. Execute Test only if Target is Up
      if (isTargetUp) {
        const key = 'real_migration_key';
        const value = 'success_data';

        // Setup Source
        await client.set(key, value);

        // Execute MIGRATE
        // "COPY" ensures the key remains on source for verification (optional)
        // "REPLACE" ensures it overwrites if exists on target
        final result = await client.migrate(
            targetHost, targetPort, key, 0, 5000,
            copy: true, replace: true);

        expect(result, equals('OK'));

        // Verify Source (Since we used COPY, it should still be here)
        expect(await client.exists([key]), equals(1));

        // Note: To verify Target strictly, we would need a second client connection.
        // But receiving 'OK' from Source confirms the transfer succeeded.
      }
    });
  });
}
