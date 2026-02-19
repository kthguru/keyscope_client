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
  group('Cuckoo Filter - Dump & Restore', () {
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

    testRedis('SCANDUMP and LOADCHUNK', () async {
      const sourceKey = 'cf:source';
      const destKey = 'cf:dest';

      await client.cfAdd(sourceKey, 'data1');
      await client.cfAdd(sourceKey, 'data2');

      var iterator = 0;
      final chunks = <Map<String, dynamic>>[];

      // 1. SCANDUMP
      while (true) {
        final dumpRes = await client.cfScanDump(sourceKey, iterator);
        if (dumpRes.isEmpty) break;

        final nextIter = int.parse(dumpRes[0].toString());
        final data = dumpRes[1]; // Preserve raw data

        if (nextIter == 0) {
          break; // Exit immediately to avoid saving terminating chunk
        }

        chunks.add({'iter': nextIter, 'data': data});
        iterator = nextIter;
      }

      expect(chunks, isNotEmpty);

      // 2. LOADCHUNK
      for (final chunk in chunks) {
        await client.cfLoadChunk(
            destKey, chunk['iter'] as int, chunk['data'] as Object);
      }

      // 3. Verify
      final exists1 = await client.cfExists(destKey, 'data1');
      final exists2 = await client.cfExists(destKey, 'data2');

      expect(exists1, isTrue);
      expect(exists2, isTrue);
    });
  });
}
