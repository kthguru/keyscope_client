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

import '../commands.dart';

extension SCardCommand on SetCommands {
  /// SCARD key
  ///
  /// Returns the set cardinality (number of elements) of the set stored at key.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [int]: The cardinality (number of elements) of the set, or 0 if
  /// key does not exist.
  Future<int> sCard(String key) async {
    final cmd = <String>['SCARD', key];
    return executeInt(cmd);
  }
}
