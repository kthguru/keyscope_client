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

extension SMoveCommand on SetCommands {
  /// SMOVE source destination member
  ///
  /// Move [member] from the set at [source] to the set at [destination].
  /// This operation is atomic.
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [bool]: true if the element is moved. false if the element is not
  /// a member of source and no operation was performed.
  Future<bool> sMove(String source, String destination, String member) async {
    final cmd = <String>['SMOVE', source, destination, member];
    final result = await executeInt(cmd);
    return result == 1;
  }
}
