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

extension IncrByFloatCommand on StringCommands {
  /// INCRBYFLOAT key increment
  ///
  /// Increment the string representing a floating point number stored at [key]
  /// by the specified [increment].
  ///
  /// Complexity: O(1)
  ///
  /// Returns:
  /// - [double]: The value of key after the increment.
  Future<double> incrByFloat(String key, double increment) async {
    final cmd = <String>['INCRBYFLOAT', key, increment.toString()];
    final result = await execute(cmd);
    if (result is double) return result;
    if (result is String) return double.parse(result);
    throw Exception(
        'Unexpected return type for INCRBYFLOAT: ${result.runtimeType}');
  }
}
