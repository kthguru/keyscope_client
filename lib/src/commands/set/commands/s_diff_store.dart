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

extension SDiffStoreCommand on SetCommands {
  /// SDIFFSTORE destination key [key ...]
  ///
  /// This command is equal to SDIFF, but instead of returning
  /// the resulting set, it is stored in [destination].
  /// If [destination] already exists, it is overwritten.
  ///
  /// Complexity: O(N) where N is the total number of elements in
  /// all given sets.
  ///
  /// Returns:
  /// - [int]: The number of elements in the resulting set.
  Future<int> sDiffStore(String destination, String key,
      [List<String> otherKeys = const []]) async {
    final cmd = <String>['SDIFFSTORE', destination, key, ...otherKeys];
    return executeInt(cmd);
  }
}
