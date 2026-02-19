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

import '../commands.dart' show CuckooFilterCommands, ServerVersionCheck;

extension CfInsertCommand on CuckooFilterCommands {
  /// CF.INSERT key [CAPACITY capacity] `[NOCREATE]` ITEMS item [item ...]
  Future<List<bool>> cfInsert(
    String key,
    List<String> items, {
    int? capacity,
    bool noCreate = false,
    bool forceRun = false,
  }) async {
    await checkValkeySupport('CF.INSERT', forceRun: forceRun);

    final cmd = <dynamic>['CF.INSERT', key];
    if (capacity != null) cmd.addAll(['CAPACITY', capacity]);
    if (noCreate) cmd.add('NOCREATE');
    cmd.add('ITEMS');
    cmd.addAll(items);

    final result = await execute(cmd);
    if (result is List) return result.map((e) => e == 1 || e == true).toList();
    return [];
  }
}
