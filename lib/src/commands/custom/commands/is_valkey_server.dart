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

import '../commands.dart' show CustomCommands;

/// ServerTypeCheck
extension CheckValkeyServerCommand on CustomCommands {
  /// Checks if the connected server is a Redis server or a Valkey server.
  ///
  /// This method parses the output of the 'INFO server' command.
  /// Valkey servers typically include 'valkey_version' or 'server_name:valkey'.
  ///
  /// Returns:
  /// - [`true`] if the server appears to be Redis.
  /// - [`false`] if the server appears to be Valkey.
  Future<bool> checkValkeyServer() async {
    try {
      // Retrieve server information section
      final infoString = await info(section: ['server']);

      // Check for Valkey specific indicators in the INFO output.
      if (infoString.contains('valkey_version') ||
          infoString.contains('server_name:valkey')) {
        return true;
      }

      // If no Valkey indicators are found, assume it is Redis.
      return false;
    } catch (e) {
      // Fallback: If INFO fails, assume Redis (default behavior)
      // or handle error.
      return false;
    }
  }
}
