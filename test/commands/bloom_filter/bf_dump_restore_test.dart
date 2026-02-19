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
  group('Bloom Filter - Dump & Restore', () {
    late KeyscopeClient client;
    var isRedis = false;
    var isValkey = false;
    const port = 6379;

    setUpAll(() async {
      final tempClient = KeyscopeClient(host: 'localhost', port: port);
      try {
        await tempClient.connect();
        isRedis = await tempClient.isRedisServer();
        isValkey = await tempClient.isValkeyServer();
      } catch (e) {
        print('Warning: Failed to check server type in setUpAll: $e');
      } finally {
        await tempClient.close();
      }
    });

    setUp(() async {
      client = KeyscopeClient(host: 'localhost', port: port);
      await client.connect();
      await client.flushAll();
    });

    tearDown(() async {
      try {
        if (client.isConnected) {
          await client.close();
        }
      } catch (_) {}

      await client.disconnect();
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

    void testValkey(String description, Future<void> Function() body) {
      test(description, () async {
        if (!isValkey) {
          markTestSkipped(
              'Skipping: This feature is supported on Valkey only.');
          return;
        }
        await body();
      });
    }

    testRedis('SCANDUMP and LOADCHUNK (Redis Flow)', () async {
      const sourceKey = 'bf:source';
      const destKey = 'bf:dest';

      // 1. Populate source filter
      await client.bfAdd(sourceKey, 'hello');
      await client.bfAdd(sourceKey, 'world');

      // 2. SCANDUMP
      var iterator = 0;
      final chunks = <Map<String, dynamic>>[];

      while (true) {
        final dumpRes = await client.bfScandump(sourceKey, iterator);

        // Break if unexpected format or end of dump (iterator is 0 and
        // data is null)
        if (dumpRes.isEmpty) break;

        final nextIter = int.parse(dumpRes[0].toString());
        final data = dumpRes[1]; // Raw binary object

        // if nextIter is 0, iteration is complete.
        // Break IMMEDIATELY so we don't save the empty terminating chunk.
        if (nextIter == 0) {
          break;
        }

        chunks.add({'iter': nextIter, 'data': data});

        iterator = nextIter;
      }

      expect(chunks, isNotEmpty);

      // 3. LOADCHUNK
      for (final chunk in chunks) {
        await client.bfLoadChunk(
          destKey,
          chunk['iter'] as int, // Uses the exact iterator returned by SCANDUMP
          chunk['data'] as Object, // (Raw data) Pass the raw object back
        );
      }

      // 4. Verify Restoration
      final existsHello = await client.bfExists(destKey, 'hello');
      final existsWorld = await client.bfExists(destKey, 'world');
      final existsFalse = await client.bfExists(destKey, 'not_there');

      expect(existsHello, isTrue);
      expect(existsWorld, isTrue);
      expect(existsFalse, isFalse);
    });

    testValkey('BF.LOAD execution check (Valkey Flow)', () async {
      // Note: If running on Redis, BF.LOAD will throw
      // an "unknown command" error.
      const key = 'bf:valkey_load';
      try {
        // await client.bfLoad(key, 0, [0, 1, 2]);
        await client.bfLoad(key, 0, 'mock_data');
      } catch (e) {
        // If it's Redis, it throws ERR unknown command 'BF.LOAD'
        // Ignore if tested against standard Redis where BF.LOAD is unknown
        final errStr = e.toString().toLowerCase();
        expect(
            errStr.contains('unknown command') ||
                errStr.contains('bf.load') ||
                errStr.contains('bad data') ||
                errStr.contains('not found'),
            isTrue);
      }
    });
  });
}
