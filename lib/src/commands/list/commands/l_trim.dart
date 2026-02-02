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

import '../commands.dart' show ListCommands;

extension LTrimCommand on ListCommands {
  /// LTRIM key start stop
  ///
  /// Trim an existing list so that it will contain only the specified range of
  /// elements specified.
  /// Both [start] and [stop] are zero-based indexes.
  ///
  /// Complexity: O(N) where N is the number of elements to be removed by
  /// the operation.
  ///
  /// Returns:
  /// - 'OK'.
  Future<String> lTrim(String key, int start, int stop) async {
    final cmd = <String>['LTRIM', key, start.toString(), stop.toString()];
    return executeString(cmd);
  }
}
