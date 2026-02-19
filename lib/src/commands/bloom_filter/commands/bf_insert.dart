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

extension BfInsertCommand on BloomFilterCommands {
  /// BF.INSERT key [CAPACITY capacity] [ERROR error] [EXPANSION expansion]
  /// `[NOCREATE]` `[NONSCALING]` ITEMS item [item ...]
  ///
  /// Adds one or more items to the Bloom Filter, creating it if it doesn't
  /// exist (unless NOCREATE is used).
  Future<List<bool>> bfInsert(
    String key,
    List<String> items, {
    int? capacity,
    double? error,
    int? expansion,
    bool noCreate = false,
    bool nonScaling = false,
    bool forceRun = false,
  }) async {
    final cmd = <dynamic>['BF.INSERT', key];

    if (capacity != null) cmd.addAll(['CAPACITY', capacity]);
    if (error != null) cmd.addAll(['ERROR', error]);
    if (expansion != null) cmd.addAll(['EXPANSION', expansion]);
    if (noCreate) cmd.add('NOCREATE');
    if (nonScaling) cmd.add('NONSCALING');

    cmd.add('ITEMS');
    cmd.addAll(items);

    final result = await execute(cmd);

    if (result is List) {
      return result.map((e) => e == 1 || e == true).toList();
    }
    return [];
  }
}
