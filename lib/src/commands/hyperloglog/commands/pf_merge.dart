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

extension PfMergeCommand on HyperLogLogCommands {
  /// PFMERGE destkey sourcekey [sourcekey ...]
  ///
  /// Merge N different HyperLogLogs into a single one.
  ///
  /// Complexity: O(N) to merge N HyperLogLogs, but with high constant times.
  ///
  /// Returns:
  /// - [String]: Simple string reply (usually "OK").
  Future<String> pfMerge(String destKey, List<String> sourceKeys) async {
    final cmd = <String>['PFMERGE', destKey, ...sourceKeys];
    return executeString(cmd);
  }
}
