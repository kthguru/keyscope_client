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

/// This library provides a Redis-compatible interface.
///
/// It allows users to use the client with familiar class names (e.g.,
/// [RedisClient], [RedisException]).
/// This is a wrapper around `keyscope_client` to provide a seamless developer
/// experience (DX)
/// for those migrating from Redis or preferring Redis terminology.
library;

import '../keyscope_client.dart';

// --- Clients ---

/// Alias for [KeyscopeClient]. Use this for Standalone/Sentinel connections.
typedef RedisClient = KeyscopeClient;

/// Alias for [KeyscopeClusterClient]. Use this for Cluster connections.
typedef RedisClusterClient = KeyscopeClusterClient;

/// Alias for [KeyscopePool]. Use this for connection pooling.
typedef RedisPool = KeyscopePool;

// --- Configuration ---

/// Alias for [KeyscopeConnectionSettings].
typedef RedisConnectionSettings = KeyscopeConnectionSettings;

/// Alias for [KeyscopeLogLevel].
typedef RedisLogLevel = KeyscopeLogLevel;

// --- Data Models ---

/// Alias for [KeyscopeMessage]. Represents a Pub/Sub message.
typedef RedisMessage = KeyscopeMessage;

// --- Exceptions (Crucial for try-catch blocks) ---

/// Alias for [KeyscopeException]. The base class for all exceptions.
typedef RedisException = KeyscopeException;

/// Alias for [KeyscopeConnectionException]. Thrown on network/socket errors.
typedef RedisConnectionException = KeyscopeConnectionException;

/// Alias for [KeyscopeServerException]. Thrown when the server responds with
/// an error.
typedef RedisServerException = KeyscopeServerException;

/// Alias for [KeyscopeClientException]. Thrown on invalid API usage.
typedef RedisClientException = KeyscopeClientException;

/// Alias for [KeyscopeParsingException]. Thrown on protocol parsing errors.
typedef RedisParsingException = KeyscopeParsingException;

/// Alias for [KeyscopeLogger].
typedef RedisLogger = KeyscopeLogger;
