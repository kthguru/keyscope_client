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

extension BfReserveCommand on BloomFilterCommands {
  /// BF.RESERVE key error_rate capacity [EXPANSION expansion]
  /// `[NONSCALING]`
  ///
  /// Creates an empty Bloom Filter with a specified error rate and
  /// initial capacity.
  ///
  /// [key]: The key under which the filter is found.
  /// [errorRate]: The desired probability for false positives (e.g.,
  ///              0.01 for 1%).
  /// [capacity]: The number of entries you intend to add to the filter.
  /// [expansion]: Expansion rate for scaling. Default is 2.
  /// [nonScaling]: If true, prevents the filter from creating
  ///               additional sub-filters when full.
  /// [forceRun]: Force execution.
  Future<dynamic> bfReserve(
    String key,
    double errorRate,
    int capacity, {
    int? expansion,
    bool nonScaling = false,
    bool forceRun = false,
  }) async {
    final cmd = <dynamic>['BF.RESERVE', key, errorRate, capacity];

    if (expansion != null) {
      cmd.addAll(['EXPANSION', expansion]);
    }

    if (nonScaling) {
      cmd.add('NONSCALING');
    }

    return execute(cmd);
  }
}
