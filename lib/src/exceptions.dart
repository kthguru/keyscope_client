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

/// The base class for all exceptions thrown by the keyscope_client package.
class KeyscopeException implements Exception {
  final String message;

  KeyscopeException(this.message);

  @override
  String toString() => 'KeyscopeException: $message';
}

/// Thrown when the client fails to connect to the server (e.g., connection
/// refused)
/// or if an established connection is lost.
/// Corresponds to socket-level or network errors.
class KeyscopeConnectionException extends KeyscopeException {
  /// The original socket exception (e.g., `SocketException`) or error, if
  /// available.
  final Object? originalException;

  KeyscopeConnectionException(super.message, [this.originalException]);

  @override
  String toString() =>
      'KeyscopeConnectionException: $message (Original: $originalException)';
}

/// Thrown when the Valkey server returns an error reply
/// (e.g., -ERR, -WRONGPASS).
/// These are errors reported by the server itself, indicating a command
/// could not be processed.
class KeyscopeServerException extends KeyscopeException {
  /// The error code or type returned by the server (e.g., "ERR", "WRONGPASS",
  /// "EXECABORT").
  final String code;

  KeyscopeServerException(super.message) : code = message.split(' ').first;

  @override
  String toString() => 'KeyscopeServerException($code): $message';
}

/// Thrown when a command is issued in an invalid client state.
///
/// Examples:
/// * Calling `EXEC` without `MULTI`.
/// * Calling `PUBLISH` while the client is in Pub/Sub mode.
/// * Mixing `SUBSCRIBE` and `PSUBSCRIBE` on the same client.
class KeyscopeClientException extends KeyscopeException {
  KeyscopeClientException(super.message);

  @override
  String toString() => 'KeyscopeClientException: $message';
}

/// Thrown if the client cannot parse the server's response.
///
/// This may indicate corrupted data, a bug in the client,
/// or an unsupported RESP (Redis Serialization Protocol) version.
class KeyscopeParsingException extends KeyscopeException {
  KeyscopeParsingException(super.message);

  @override
  String toString() => 'KeyscopeParsingException: $message';
}

/// Simple exception to signal an intentionally unimplemented feature.
///
/// Simple, user-facing exception to signal an intentionally unimplemented
/// feature. Prefer this over throwing `UnimplementedError` when callers
/// should be able to catch and handle the condition.
///
/// Throw:
/// ```dart
/// throw const FeatureNotImplementedException('this feature is not ready');
/// ```
///
/// Catch:
/// ```dart
/// } on FeatureNotImplementedException catch (e) {
///   print('Feature not implemented: $e');
/// }
/// ```
class FeatureNotImplementedException implements Exception {
  final String message;
  const FeatureNotImplementedException([this.message = '']);
  @override
  String toString() => message.isEmpty
      ? 'FeatureNotImplementedException'
      : 'FeatureNotImplementedException: $message';
}
