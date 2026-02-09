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

/// The ultimate multi-engine client for Redis, Valkey, and Dragonfly.
///
/// A high-performance, cluster-aware SDK with seamless polymorphic aliases.
/// Switch identities seamlessly with built-in polymorphic aliases.
library;

export 'engines/dragonfly_client.dart';
export 'engines/redis_client.dart';
export 'engines/valkey_client.dart';
export 'keyscope_client_base.dart'
    show
        KeyscopeClientBase,
        KeyscopeConnectionSettings,
        KeyscopeMessage,
        LoadBalancingStrategy,
        ReadPreference,
        RunningMode,
        ServerMetadata,
        Subscription;
export 'keyscope_client_pool.dart';
export 'keyscope_cluster_client_base.dart';
export 'keyscope_commands_base.dart';
export 'src/cluster_info.dart';
export 'src/commands/bitmap/extensions.dart';
export 'src/commands/bloom_filter/extensions.dart';
export 'src/commands/cluster/extensions.dart';
export 'src/commands/connection/extensions.dart';
export 'src/commands/count_min_sketch/extensions.dart';
export 'src/commands/cuckoo_filter/extensions.dart';
export 'src/commands/generic/commands.dart' show ScanResult;
export 'src/commands/generic/commands/scan_cli.dart' show ScanResult;
export 'src/commands/generic/extensions.dart';
export 'src/commands/geospatial_indices/commands.dart'
    show GeoLocation, GeoRadiusOptions, GeoSearchOptions;
export 'src/commands/geospatial_indices/extensions.dart';
export 'src/commands/hash/extensions.dart';
export 'src/commands/hyperloglog/extensions.dart';
export 'src/commands/json/commands.dart'
    show Config, JsonCommands, JsonMSetEntry;
export 'src/commands/json/extensions.dart';
export 'src/commands/list/extensions.dart';
export 'src/commands/pubsub/extensions.dart';
export 'src/commands/scripting_and_functions/extensions.dart';
export 'src/commands/search/extensions.dart';
export 'src/commands/server/extensions.dart';
export 'src/commands/set/extensions.dart';
export 'src/commands/sorted_set/extensions.dart';
export 'src/commands/stream/commands.dart' show StreamEntry;
export 'src/commands/stream/extensions.dart';
export 'src/commands/string/extensions.dart';
export 'src/commands/t_digest_sketch/extensions.dart';
export 'src/commands/time_series/extensions.dart';
export 'src/commands/top_k_sketch/extensions.dart';
export 'src/commands/transactions/extensions.dart';
export 'src/commands/vector_set/extensions.dart';
export 'src/exceptions.dart';
export 'src/keyscope_client.dart';
export 'src/keyscope_cluster_client.dart';
export 'src/logging.dart' show KeyscopeLogLevel, KeyscopeLogger;
