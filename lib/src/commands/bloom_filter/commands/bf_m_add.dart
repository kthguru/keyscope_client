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

import '../commands.dart' show BloomFilterCommands;

extension BfMAddCommand on BloomFilterCommands {
  /// BF.MADD key item [item ...]
  ///
  /// Adds one or more items to the Bloom Filter.
  ///
  /// Returns a list of booleans (true if added, false if already present).
  Future<List<bool>> bfMAdd(
    String key,
    List<String> items, {
    bool forceRun = false,
  }) async {
    final result = await execute(['BF.MADD', key, ...items]);

    if (result is List) {
      // Redis returns 1 for added, 0 for already exists
      return result.map((e) => e == 1 || e == true).toList();
    }
    return [];
  }
}
