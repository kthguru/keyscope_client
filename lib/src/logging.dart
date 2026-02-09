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

// ignore_for_file: constant_identifier_names

/// Defines logging severity levels.
///
/// Follows the levels from `package:logging`.
class KeyscopeLogLevel {
  final String name;
  final int value;

  const KeyscopeLogLevel(this.name, this.value);

  /// Fine-grained tracing
  static const KeyscopeLogLevel fine = KeyscopeLogLevel('FINE', 500);

  /// Informational messages
  static const KeyscopeLogLevel info = KeyscopeLogLevel('INFO', 700);

  /// Potential problems
  static const KeyscopeLogLevel warning = KeyscopeLogLevel('WARNING', 800);

  /// Serious failures
  static const KeyscopeLogLevel severe = KeyscopeLogLevel('SEVERE', 1000);

  /// Error messages
  static const KeyscopeLogLevel error = KeyscopeLogLevel('ERROR', 1400);

  /// Disables logging.
  static const KeyscopeLogLevel off = KeyscopeLogLevel('OFF', 2000);

  /// Enables logging.
  static const EnableKeyscopeLog = false;

  bool operator <(KeyscopeLogLevel other) => value < other.value;
  bool operator <=(KeyscopeLogLevel other) => value <= other.value;

  // Legacy identifiers kept for backward compatibility (deprecated)
  @Deprecated('Since 1.1.0: Use "severe" instead')
  static const KeyscopeLogLevel SEVERE = severe;

  @Deprecated('Since 1.1.0: Use "warning" instead')
  static const KeyscopeLogLevel WARNING = warning;

  @Deprecated('Since 1.1.0: Use "info" instead')
  static const KeyscopeLogLevel INFO = info;

  @Deprecated('Since 1.1.0: Use "fine" instead')
  static const KeyscopeLogLevel FINE = fine;

  @Deprecated('Since 1.1.0: Use "off" instead')
  static const KeyscopeLogLevel OFF = off;
}

/// A simple internal logger for the keyscope_client.
///
/// This avoids adding an external dependency on `package:logging`.
class KeyscopeLogger {
  final String name;
  static KeyscopeLogLevel level =
      KeyscopeLogLevel.off; // Logging is off by default
  bool _enableKeyscopeLog = KeyscopeLogLevel.EnableKeyscopeLog;
  void setEnableKeyscopeLog(bool status) => _enableKeyscopeLog = status;

  KeyscopeLogger(this.name);

  void setLogLevelFine() {
    level = KeyscopeLogLevel.fine;
  }

  void setLogLevelInfo() {
    level = KeyscopeLogLevel.info;
  }

  void setLogLevelWarning() {
    level = KeyscopeLogLevel.warning;
  }

  void setLogLevelSevere() {
    level = KeyscopeLogLevel.severe;
  }

  void setLogLevelError() {
    level = KeyscopeLogLevel.error;
  }

  void setLogLevelOff() {
    level = KeyscopeLogLevel.off;
  }

  /// Logs a message if [messageLevel] is at or above the current [level].
  void _log(KeyscopeLogLevel messageLevel, String message,
      [Object? error, StackTrace? stackTrace]) {
    if (!_enableKeyscopeLog) {
      if (messageLevel.value < KeyscopeLogger.level.value) {
        return; // Log level is too low, ignore.
      }
    }

    // Simple print-based logging. Users can configure this later.
    print('[${DateTime.now().toIso8601String()}] $name - '
        '${messageLevel.name}: $message');
    if (error != null) {
      print('  Error: $error');
    }
    if (stackTrace != null) {
      print('  Stacktrace:\n$stackTrace');
    }
  }

  void fine(String message) {
    _log(KeyscopeLogLevel.fine, message);
  }

  void info(String message) {
    _log(KeyscopeLogLevel.info, message);
  }

  void warning(String message, [Object? error]) {
    _log(KeyscopeLogLevel.warning, message, error);
  }

  void severe(String message, [Object? error, StackTrace? stackTrace]) {
    _log(KeyscopeLogLevel.severe, message, error, stackTrace);
  }

  void error(String message) {
    _log(KeyscopeLogLevel.error, message);
  }
}
