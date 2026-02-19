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

import '../commands.dart' show CuckooFilterCommands, ServerVersionCheck;

extension CfReserveCommand on CuckooFilterCommands {
  /// CF.RESERVE key capacity [BUCKETSIZE bucketsize]
  /// [MAXITERATIONS maxiterations] [EXPANSION expansion]
  Future<dynamic> cfReserve(
    String key,
    int capacity, {
    int? bucketSize,
    int? maxIterations,
    int? expansion,
    bool forceRun = false,
  }) async {
    await checkValkeySupport('CF.RESERVE', forceRun: forceRun);
    final cmd = <dynamic>['CF.RESERVE', key, capacity];
    if (bucketSize != null) cmd.addAll(['BUCKETSIZE', bucketSize]);
    if (maxIterations != null) cmd.addAll(['MAXITERATIONS', maxIterations]);
    if (expansion != null) cmd.addAll(['EXPANSION', expansion]);
    return execute(cmd);
  }
}
