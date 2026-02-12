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

extension DelExCommand on StringCommands {
  /// DELEX key [IFEQ ifeq-value | IFNE ifne-value | IFDEQ ifdeq-digest |
  /// IFDNE ifdne-digest]
  ///
  /// Conditionally removes the specified key based on value or hash digest
  /// comparison.
  /// Only one of the options (ifEq, ifNe, ifDeq, ifDne) can be specified.
  ///
  /// Options:
  /// - [ifEq]: Remove if value equals the specified value.
  /// - [ifNe]: Remove if value does not equal the specified value.
  /// - [ifDeq]: Remove if hash digest equals the specified digest.
  /// - [ifDne]: Remove if hash digest does not equal the specified digest.
  ///
  /// Complexity: O(1) for IFEQ/IFNE, O(N) for IFDEQ/IFDNE.
  ///
  /// Returns:
  /// - [int]: 1 if deleted, 0 if not deleted.
  Future<int> delEx(String key,
      {String? ifEq,
      String? ifNe,
      String? ifDeq,
      String? ifDne,
      bool forceRun = false}) async {
    await checkValkeySupport('DELEX', forceRun: forceRun);

    final cmd = <String>['DELEX', key];

    // Check that at most one option is provided is handled by the server,
    // but we add parameters sequentially. The server syntax allows only one.
    if (ifEq != null) {
      cmd.add('IFEQ');
      cmd.add(ifEq);
    } else if (ifNe != null) {
      cmd.add('IFNE');
      cmd.add(ifNe);
    } else if (ifDeq != null) {
      cmd.add('IFDEQ');
      cmd.add(ifDeq);
    } else if (ifDne != null) {
      cmd.add('IFDNE');
      cmd.add(ifDne);
    }

    return executeInt(cmd);
  }
}
