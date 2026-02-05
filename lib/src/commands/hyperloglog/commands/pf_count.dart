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

extension PfCountCommand on HyperLogLogCommands {
  /// PFCOUNT key [key ...]
  ///
  /// When called with a single key, returns the approximated cardinality
  /// computed by the HyperLogLog data structure stored at the specified
  /// variable.
  /// When called with multiple keys, returns the approximated cardinality of
  /// the union of the HyperLogLogs passed.
  ///
  /// Complexity: O(1) with a very small average constant time when called with
  /// a single key. O(N) with N being the number of keys, and much larger
  /// constant time, when called with multiple keys.
  ///
  /// Returns:
  /// - [int]: The approximated number of unique elements observed via PFADD.
  Future<int> pfCount(List<String> keys) async {
    final cmd = <String>['PFCOUNT', ...keys];
    return executeInt(cmd);
  }
}
