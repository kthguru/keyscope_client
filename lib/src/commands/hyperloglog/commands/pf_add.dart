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

import '../commands.dart' show HyperLogLogCommands;

extension PfAddCommand on HyperLogLogCommands {
  /// PFADD key element [element ...]
  ///
  /// Adds all the element arguments to the HyperLogLog data structure stored at
  /// the variable name specified as key.
  ///
  /// Complexity: O(1) to add every element.
  ///
  /// Returns:
  /// - [int]: 1 if at least 1 HyperLogLog internal register was altered.
  /// 0 otherwise.
  Future<int> pfAdd(String key, List<String> elements) async {
    final cmd = <String>['PFADD', key, ...elements];
    return executeInt(cmd);
  }
}
