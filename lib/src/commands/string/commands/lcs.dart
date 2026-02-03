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

import '../commands.dart' show StringCommands;

extension LcsCommand on StringCommands {
  /// LCS key1 key2 [LEN] [IDX] [MINMATCHLEN len] [`WITHMATCHLEN`]
  ///
  /// Computes the Longest Common Subsequence between the strings stored at
  /// [key1] and [key2].
  ///
  /// Options:
  /// - [len]: If true, returns the length of the LCS (int).
  /// - [idx]: If true, returns an array with the LCS length and
  /// match positions.
  /// - [minMatchLen]: Restrict the list of matches to the ones of
  /// a given minimum length.
  /// - [withMatchLen]: When used with [idx], each match will also include
  /// its length.
  ///
  /// Complexity: O(N*M) where N and M are the lengths of the two strings.
  ///
  /// Returns:
  /// - [String]: The longest common subsequence (default).
  /// - [int]: The length of the LCS (if [len] is true).
  /// - [dynamic]: Complex array structure (if [idx] is true).
  Future<dynamic> lcs(
    String key1,
    String key2, {
    bool len = false,
    bool idx = false,
    int? minMatchLen,
    bool withMatchLen = false,
  }) async {
    final cmd = <String>['LCS', key1, key2];
    if (len) cmd.add('LEN');
    if (idx) cmd.add('IDX');
    if (minMatchLen != null) {
      cmd.add('MINMATCHLEN');
      cmd.add(minMatchLen.toString());
    }
    if (withMatchLen) cmd.add('WITHMATCHLEN');

    return execute(cmd);
  }
}
