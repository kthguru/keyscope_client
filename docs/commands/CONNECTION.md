<!--
Copyright 2025-2026 Infradise Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

# CONNECTION

`ping`, `echo`, `close`

| TypeRedis        | Redis                                                                               | Valkey                                                                   |
|----------------------|-------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| `auth`               | [AUTH](https://redis.io/docs/latest/commands/auth/)                                 | [AUTH](https://valkey.io/commands/auth/)                                 |
| `client`             | [CLIENT](https://redis.io/docs/latest/commands/client/)                             | [CLIENT](https://valkey.io/commands/client/)                             |
| `clientCaching`      | [CLIENT CACHING](https://redis.io/docs/latest/commands/client-caching/)             | [CLIENT CACHING](https://valkey.io/commands/client-caching/)             |
| `clientCapa`         | [CLIENT CAPA](https://redis.io/docs/latest/commands/client-capa/)                   | [CLIENT CAPA](https://valkey.io/commands/client-capa/)                   |
| `clientGetName`      | [CLIENT GETNAME](https://redis.io/docs/latest/commands/client-getname/)             | [CLIENT GETNAME](https://valkey.io/commands/client-getname/)             |
| `clientGetRedir`     | [CLIENT GETREDIR](https://redis.io/docs/latest/commands/client-getredir/)           | [CLIENT GETREDIR](https://valkey.io/commands/client-getredir/)           |
| `clientHelp`         | [CLIENT HELP](https://redis.io/docs/latest/commands/client-help/)                   | [CLIENT HELP](https://valkey.io/commands/client-help/)                   |
| `clientId`           | [CLIENT ID](https://redis.io/docs/latest/commands/client-id/)                       | [CLIENT ID](https://valkey.io/commands/client-id/)                       |
| `clientImportSource` | [CLIENT IMPORT-SOURCE](https://redis.io/docs/latest/commands/client-import-source/) | [CLIENT IMPORT-SOURCE](https://valkey.io/commands/client-import-source/) |
| `clientInfo`         | [CLIENT INFO](https://redis.io/docs/latest/commands/client-info/)                   | [CLIENT INFO](https://valkey.io/commands/client-info/)                   |
| `clientKill`         | [CLIENT KILL](https://redis.io/docs/latest/commands/client-kill/)                   | [CLIENT KILL](https://valkey.io/commands/client-kill/)                   |
| `clientList`         | [CLIENT LIST](https://redis.io/docs/latest/commands/client-list/)                   | [CLIENT LIST](https://valkey.io/commands/client-list/)                   |
| `clientNoEvict`      | [CLIENT NO-EVICT](https://redis.io/docs/latest/commands/client-no-evict/)           | [CLIENT NO-EVICT](https://valkey.io/commands/client-no-evict/)           |
| `clientNoTouch`      | [CLIENT NO-TOUCH](https://redis.io/docs/latest/commands/client-no-touch/)           | [CLIENT NO-TOUCH](https://valkey.io/commands/client-no-touch/)           |
| `clientPause`        | [CLIENT PAUSE](https://redis.io/docs/latest/commands/client-pause/)                 | [CLIENT PAUSE](https://valkey.io/commands/client-pause/)                 |
| `clientReply`        | [CLIENT REPLY](https://redis.io/docs/latest/commands/client-reply/)                 | [CLIENT REPLY](https://valkey.io/commands/client-reply/)                 |
| `clientSetInfo`      | [CLIENT SETINFO](https://redis.io/docs/latest/commands/client-setinfo/)             | [CLIENT SETINFO](https://valkey.io/commands/client-setinfo/)             |
| `clientSetName`      | [CLIENT SETNAME](https://redis.io/docs/latest/commands/client-setname/)             | [CLIENT SETNAME](https://valkey.io/commands/client-setname/)             |
| `clientTracking`     | [CLIENT TRACKING](https://redis.io/docs/latest/commands/client-tracking/)           | [CLIENT TRACKING](https://valkey.io/commands/client-tracking/)           |
| `clientTrackingInfo` | [CLIENT TRACKINGINFO](https://redis.io/docs/latest/commands/client-trackinginfo/)   | [CLIENT TRACKINGINFO](https://valkey.io/commands/client-trackinginfo/)   |
| `clientUnblock`      | [CLIENT UNBLOCK](https://redis.io/docs/latest/commands/client-unblock/)             | [CLIENT UNBLOCK](https://valkey.io/commands/client-unblock/)             |
| `clientUnpause`      | [CLIENT UNPAUSE](https://redis.io/docs/latest/commands/client-unpause/)             | [CLIENT UNPAUSE](https://valkey.io/commands/client-unpause/)             |
| `echo`               | [ECHO](https://redis.io/docs/latest/commands/echo/)                                 | [ECHO](https://valkey.io/commands/echo/)                                 |
| `hello`              | [HELLO](https://redis.io/docs/latest/commands/hello/)                               | [HELLO](https://valkey.io/commands/hello/)                               |
| `ping`               | [PING](https://redis.io/docs/latest/commands/ping/)                                 | [PING](https://valkey.io/commands/ping/)                                 |
| `quit`               | [QUIT](https://redis.io/docs/latest/commands/quit/)                                 | [QUIT](https://valkey.io/commands/quit/)                                 |
| `reset`              | [RESET](https://redis.io/docs/latest/commands/reset/)                               | [RESET](https://valkey.io/commands/reset/)                               |
| `select`             | [SELECT](https://redis.io/docs/latest/commands/select/)                             | [SELECT](https://valkey.io/commands/select/)                             |