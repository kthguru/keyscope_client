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

extension BfInfoCommand on BloomFilterCommands {
  /// BF.INFO key [CAPACITY | SIZE | FILTERS | ITEMS | EXPANSION]
  ///
  /// Returns information about the Bloom Filter.
  /// If [option] is provided, returns specific field value. Otherwise returns a Map/List of all info.
  Future<dynamic> bfInfo(
    String key, {
    String? option, // 'CAPACITY', 'SIZE', 'FILTERS', 'ITEMS', 'EXPANSION'
    bool forceRun = false,
  }) async {
    final cmd = <dynamic>['BF.INFO', key];
    if (option != null) {
      cmd.add(option);
    }
    return execute(cmd);
  }
}
