<br />
<div align="center">
  <h1>keyscope_client</h1>
  <p>
  <img src="https://download.keyscope.dev/logo.png" alt="Keyscope Logo" width="64">
  <br>
  </p>
  <p>
    The ultimate multi-engine client for Redis, Valkey, and Dragonfly. 
    <br><br>
    A high-performance, cluster-aware SDK with seamless polymorphic aliases.
    Switch identities seamlessly with built-in polymorphic aliases.
  </p>

  [![pub package](https://img.shields.io/pub/v/keyscope_client.svg?label=Latest)](https://pub.dev/packages/keyscope_client)
  [![CT](https://github.com/infradise/keyscope_client/actions/workflows/keyscope_client_ct.yaml/badge.svg)](https://github.com/infradise/keyscope_client/actions/workflows/keyscope_client_ct.yaml)
  [![pub package](https://img.shields.io/pub/v/keyscope.svg?label=keyscope&color=blue)](https://pub.dev/packages/keyscope)

  <p>
    <a href="#supported-commands">Supported Commands</a> •
    <a href="#usage">Usage</a> •
    <a href="#features">Features</a></a> •
    <a href="#why-keyscope_client">Why keyscope_client?</a></a>
  </p>

</div>

## Supported Commands

> **Not just basic strings.** Our goal is to provide a 100% complete command experience across all data types **in the Dart/Flutter ecosystem.**

### Core Data Types

Basic data structures and generic key operations.

* [STRING](https://github.com/infradise/keyscope_client/blob/main/docs/commands/STRING.md) / [HASH](https://github.com/infradise/keyscope_client/blob/main/docs/commands/HASH.md) / [LIST](https://github.com/infradise/keyscope_client/blob/main/docs/commands/LIST.md) / [SET](https://github.com/infradise/keyscope_client/blob/main/docs/commands/SET.md) / [SORTED SET](https://github.com/infradise/keyscope_client/blob/main/docs/commands/SORTED-SET.md)
* [BITMAP](https://github.com/infradise/keyscope_client/blob/main/docs/commands/BITMAP.md) / [HYPERLOGLOG](https://github.com/infradise/keyscope_client/blob/main/docs/commands/HYPERLOGLOG.md) / [GEOSPATIAL INDICES](https://github.com/infradise/keyscope_client/blob/main/docs/commands/GEOSPATIAL-INDICES.md) / [STREAM](https://github.com/infradise/keyscope_client/blob/main/docs/commands/STREAM.md)
* [GENERIC](https://github.com/infradise/keyscope_client/blob/main/docs/commands/GENERIC.md) (Keys, Expiration, etc.)

### Modules & Extensions

Advanced data types and query engines (JSON, Search, Probabilistic structures).

* [JSON](https://github.com/infradise/keyscope_client/blob/main/docs/commands/JSON.md) / [SEARCH](https://github.com/infradise/keyscope_client/blob/main/docs/commands/SEARCH.md) / [TIME SERIES](https://github.com/infradise/keyscope_client/blob/main/docs/commands/TIME-SERIES.md) / [VECTOR SET](https://github.com/infradise/keyscope_client/blob/main/docs/commands/VECTOR-SET.md)
* [BLOOM FILTER](https://github.com/infradise/keyscope_client/blob/main/docs/commands/BLOOM-FILTER.md) / [CUCKOO FILTER](https://github.com/infradise/keyscope_client/blob/main/docs/commands/CUCKOO-FILTER.md)
* [COUNT-MIN SKETCH](https://github.com/infradise/keyscope_client/blob/main/docs/commands/COUNT-MIN-SKETCH.md) / [T-DIGEST SKETCH](https://github.com/infradise/keyscope_client/blob/main/docs/commands/T-DIGEST-SKETCH.md) / [TOP-K SKETCH](https://github.com/infradise/keyscope_client/blob/main/docs/commands/TOP-K-SKETCH.md)

### System & Operations

Server management, connection handling, and flow control.

* [CONNECTION](https://github.com/infradise/keyscope_client/blob/main/docs/commands/CONNECTION.md) / [SERVER](https://github.com/infradise/keyscope_client/blob/main/docs/commands/SERVER.md) / [CLUSTER](https://github.com/infradise/keyscope_client/blob/main/docs/commands/CLUSTER.md)
* [PUBSUB](https://github.com/infradise/keyscope_client/blob/main/docs/commands/PUBSUB.md) / [TRANSACTIONS](https://github.com/infradise/keyscope_client/blob/main/docs/commands/TRANSACTIONS.md) / [SCRIPTING AND FUNCTIONS](https://github.com/infradise/keyscope_client/blob/main/docs/commands/SCRIPTING-AND-FUNCTIONS.md)

## Usage

> **KeyscopeClient** provides a unified API with full alias sets for **Redis**, **Valkey**, and **Dragonfly** (including Client, ClusterClient, Pool, Exceptions, Configuration, and Data Models). Whether you prefer engine-specific naming or a unified approach, we've got you covered. (Check out [Developer Experience Improvements](https://github.com/infradise/keyscope_client/wiki/Developer-Experience-Improvements)).


### 1\-1\. Redis, Valkey, and Dragonfly Standalone (Basic)

<table>
<tr>
<td>

**`For Redis users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final client = RedisClient(
    host: 'localhost', 
    port: 6379, 
    // password: '',
  );
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Redis!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
<td>

**`For Valkey users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final client = ValkeyClient(
    host: 'localhost', 
    port: 6379, 
    // password: '',
  );
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Valkey!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
<td>

**`For Dragonfly users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final client = DragonflyClient(
    host: 'localhost', 
    port: 6379, 
    // password: '',
  );
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Dragonfly!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
</tr>
</table>


### 1\-2\. Redis, Valkey, and Dragonfly Standalone (Advanced)

<table>
<tr>
<td>

**`For Redis users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final settings = RedisConnectionSettings(
    host: 'localhost',
    port: 6379,
    // useSsl: false,
    // database: 0,
  );
  final client = RedisClient.fromSettings(settings);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Redis!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
<td>

**`For Valkey users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final settings = ValkeyConnectionSettings(
    host: 'localhost',
    port: 6379,
    // useSsl: false,
    // database: 0,
  );
  final client = ValkeyClient.fromSettings(settings);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Valkey!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
<td>

**`For Dragonfly users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final settings = DragonflyConnectionSettings(
    host: 'localhost',
    port: 6379,
    // useSsl: false,
    // database: 0,
  );
  final client = DragonflyClient.fromSettings(settings);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Dragonfly!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
</tr>
</table>

### 2\. Redis, Valkey, and Dragonfly Sentinel

<table>
<tr>
<td>

**`For Redis users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final settings = RedisConnectionSettings(
    host: 'localhost',
    port: 6379,
    readPreference: ReadPreference.preferReplica
  );
  final client = RedisClient.fromSettings(settings);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Redis!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
<td>

**`For Valkey users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final settings = ValkeyConnectionSettings(
    host: 'localhost',
    port: 6379,
    readPreference: ReadPreference.preferReplica
  );
  final client = ValkeyClient.fromSettings(settings);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Valkey!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
<td>

**`For Dragonfly users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final settings = DragonflyConnectionSettings(
    host: 'localhost',
    port: 6379,
    readPreference: ReadPreference.preferReplica
  );
  final client = DragonflyClient.fromSettings(settings);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Dragonfly!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
</tr>
</table>

### 3\. Redis, Valkey, and Dragonfly Cluster

<table>
<tr>
<td>

**`For Redis users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final nodes = [
    RedisConnectionSettings(
      host: 'localhost', 
      port: 7001,
    )
  ];
  final client = RedisClusterClient(nodes);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Redis!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
<td>

**`For Valkey users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final nodes = [
    ValkeyConnectionSettings(
      host: 'localhost', 
      port: 7001,
    )
  ];
  final client = ValkeyClusterClient(nodes);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Valkey!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
<td>

**`For Dragonfly users`**

```dart
import 'package:keyscope_client/keyscope_client.dart';

void main() async {
  final nodes = [
    DragonflyConnectionSettings(
      host: 'localhost', 
      port: 7001,
    )
  ];
  final client = DragonflyClusterClient(nodes);
  try {
    await client.connect();
    await client.set('Hello', 'Welcome to Dragonfly!');
    print(await client.get('Hello'));
  } catch (e) {
    print('Error: $e');
  } finally {
    await client.close();
  }
}
```

</td>
</tr>
</table>


## Features

### 🚀 Performance & Scalability

| Feature | Description |
| :------ | :---------- |
| **Scalable Replica Reads**| Boost read performance by offloading read-only commands (e.g., `GET`, `EXISTS`) <br>to replica nodes. Supports `ReadPreference` settings (`master`, `preferReplica`, `replicaOnly`) to control traffic flow. |
| **Smart Load Balancing** | Built-in load balancing strategies (`Round-Robin`, `Random`) to efficiently distribute read traffic across available replicas. |
| **Multi-key Support**| Supports `MGET` across multiple nodes using smart Scatter-Gather pipelining.|
| **Sharded Pub/Sub & Atomic Counters** | Added support for high-performance cluster messaging (`SPUBLISH`/`SSUBSCRIBE`) and atomic integer operations (`INCR`/`DECR`). |

### 🛡️ High Availability & Resilience

| Feature | Description |
| :------ | :---------- |
| **Automatic Failover** |**Resilience:** The client now survives node failures. If a master node goes down <br>(connection refused/timeout), the client automatically refreshes the <br>cluster topology and reroutes commands to the new master without throwing an exception. |
| **High Availability & Resilience** | Automatically and transparently handles cluster topology changes <br>(`-MOVED` and `-ASK` redirections) to ensure robust failover, seamless scaling, and zero‑downtime operations. |
| **Automatic Replica Discovery**| Automatically detects and connects to replica nodes via <br>`INFO REPLICATION` (Standalone/Sentinel) to maintain an up-to-date pool of connections. |
| **Cluster Auto-Discovery** | Added `client.clusterSlots()` to fetch cluster topology <br>(via the `CLUSTER SLOTS` command), laying the foundation for full cluster support. |

### 🧩 Developer Experience & Tooling

| Feature | Description |
| :------ | :---------- |
| **Redis/Valkey Module Detector** | Retrieves module metadata to identify installed extensions <br>(e.g., `json`, `search`, `ldap`, `bf`). |
| **JSON Module Checker** | Pre-validates JSON module availability before execution. |
| **Server Metadata Discovery** | Access server details via `client.metadata` (Version, Mode, Server Name, <br>Max Databases) to write adaptive logic for Valkey vs. Redis. |
| **Enhanced Developer Experience** | Provides full alias sets for `Redis` and `Valkey`, and `Dragonfly`—including Exceptions, Configuration, and Data Models <br>(e.g., `RedisException`, `RedisMessage`, `ValkeyException`, `ValkeyMessage`, `DragonflyException`, `DragonflyMessage`)—to ensure API consistency and simplify backend migration. |
| **Developer Experience** | Added `RedisClient` and `ValkeyClient`, `DragonflyClient` alias and smart redirection handling for better usability and stability. |
| **Type-Safe Exceptions** | Clear distinction between connection errors (`KeyscopeClientConnectionException`), <br>server errors (`KeyscopeClientServerException`), and client errors (`KeyscopeClientClientException`). |
| **Observability** | Built-in logging. |
| **Multi-Engine Ready** | Built for the modern ecosystem (Redis, Valkey, Dragonfly). |
| **Identity Switch** | Use `RedisClient`, `ValkeyClient`, or `DragonflyClient` — whatever suits your project's heart. |

### 🔌 Connection & Configuration

| Feature | Description |
| :------ | :---------- |
| **Smart Database Selection** | First-class support for selecting databases (0-15+) on connection. <br>Automatically detects **Valkey 9.0+ Numbered Clusters** to enable multi-database support <br>in cluster mode, while maintaining backward compatibility with Redis Clusters (DB 0 only). |
| **Explicit Replica Configuration** | Added `explicitReplicas` to `KeyscopeClientConnectionSettings` to manually define replica nodes, <br>solving connectivity issues in environments where auto-discovery fails. |
| **Cluster Client** | **KeyscopeClusterClient:** Dedicated client for automatic command routing in cluster mode. <br>We recommend using `KeyscopeClientClient` for Standalone/Sentinel and `KeyscopeClientClusterClient` for cluster environments. |
| **Built-in Connection Pooling** | `KeyscopeClientPool` for efficient connection management (used by Standalone and Cluster clients). |
| **Connection Pool Hardening** | **Smart Release Mechanism:** Prevents pool pollution by automatically detecting and <br>discarding "dirty" connections (e.g., inside Transaction or Pub/Sub) upon release. |
| **Command Timeout** | Includes a built-in command timeout (via `KeyscopeClientConnectionSettings`) <br>to prevent client hangs on non-responsive servers. |

### 🔒 Security & Core

| Feature | Description |
| :------ | :---------- |
| **Enterprise Security** | Native SSL/TLS support compatible with major cloud providers (AWS, Azure, GCP). Supports custom security contexts (including self-signed certificates). |
| **Robust Parsing** | Full RESP3 parser handling all core data types (`+`, `-`, `$`, `*`, `:`). |
| **Pub/Sub Ready (Standalone/Sentinel)** | `subscribe()` returns a `Subscription` object with a `Stream` and a `Future<void> ready` for easy and reliable message handling. |
| **Production-Ready** | **Standalone/Sentinel:** Stable for production use.<br>**Cluster:** Stable for production use with full cluster support. |

## Why keyscope_client?

While existing tools are heavy (Electron-based) or lack support for modern features, the [Keyscope GUI](https://pub.dev/packages/keyscope) runs natively with built-in multilingual support. **keyscope_client** brings that same philosophy to your code.

Unlike traditional clients that act as simple wrappers around raw command strings, **keyscope_client** provides a **Type-Safe, Idiomatic Dart API**. We don't just send commands; we abstract them into a developer-friendly interface that feels native to the Dart ecosystem.

### 🎯 True "Dart-like" Abstraction

Traditional clients often rely on sending raw command lists. While flexible, this approach requires you to memorize Redis syntax, handle type conversions manually, and risk runtime errors from simple typos.

**keyscope_client** balances **ergonomics** for simple commands with **clarity** for complex ones, leveraging Dart's **Named Parameters** and **Strong Typing** to prevent mistakes before they happen.

#### ❌ The Traditional Way: Raw & Loose

**Scenario 1: The "Magic String" Problem**

> *Sending raw strings offers no autocomplete or type safety.*

```dart
// ⚠️ Is it 'GET' or 'get'? Did I pass the key as a list or string?
final value = await client.send_command(['GET', 'my_key']); 
```

**Scenario 2: The "Memory Test" Problem**

> *Complex commands require memorizing the exact order and spelling of options.*

```dart
// ⚠️ Hard to read. Easy to typo 'AGGREGATION'. What does '1000' mean?
await client.send_command([
  'TS.MRANGE', '-', '+', 'FILTER', 'label=cpu', 
  'AGGREGATION', 'avg', '1000'
]);
```

**Scenario 3: The "Loose Wrapper" Problem**

> *Some wrappers exist but still accept raw lists for options, leaving room for errors.*

```dart
// ⚠️ Ambiguous: Is it 'ALIGN' or 'align'? Is the timestamp a string or int?
client.tsMRange('-', '+', ['label=cpu'],
  options: ['ALIGN', 'start', 'AGGREGATION', 'avg', 1000]
);
```

#### ✅ The Keyscope Way: Safe, Pragmatic, & Type-Safe

**Solution 1: Ergonomics for Simple Logic (Positional)**

> *For simple lookups, we keep it short and sweet. No unnecessary named parameters.*

```dart
// 🚀 Simple, intuitive, and exactly what you expect.
final value = await client.get('my_key');
```

**Solution 2: Clarity for Complex Logic (Named)**

> *For advanced commands, we use Named Parameters to make code self-documenting.*
> *IDE provides autocompletion. Options are explicit. Errors are caught at compile time.*

```dart
// 🛡️ Type-safe. IDE suggests options. No magic numbers.
await client.tsMRange(
  fromTimestamp: '-', 
  toTimestamp: '+', 
  filter: ['label=cpu'], // 💡 Clear intent
  align: 'start',        // 💡 Explicit Named Parameter
  aggregator: 'avg',     // 💡 Explicit option, No magic strings
  bucketDuration: 1000,  // 💡 Typed inputs
  count: 10,
  withLabels: true
);
```

### ⚡ Multi-Engine Core

Just like the **[Keyscope GUI](https://pub.dev/packages/keyscope)**, this client provides a unified, production-ready interface for the modern data stack.

**keyscope_client** respects your infrastructure choices. Whether you run **[Redis](https://redis.io)**, **[Valkey](https://valkey.io)**, or **[Dragonfly](https://www.dragonflydb.io/)**, simply choose the alias that matches your backend (`RedisClient`, `ValkeyClient`, `DragonflyClient`).

**One Unified API:** Switch identities seamlessly to match your evolving infrastructure without rewriting a single line of your business logic.