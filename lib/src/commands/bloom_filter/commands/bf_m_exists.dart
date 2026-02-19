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

extension BfMExistsCommand on BloomFilterCommands {
  /// BF.MEXISTS key item [item ...]
  ///
  /// Determines if one or more items may exist in the filter.
  Future<List<bool>> bfMExists(
    String key,
    List<String> items, {
    bool forceRun = false,
  }) async {
    final result = await execute(['BF.MEXISTS', key, ...items]);

    if (result is List) {
      return result.map((e) => e == 1 || e == true).toList();
    }
    return [];
  }
}
