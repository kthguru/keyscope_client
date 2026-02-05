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

# STREAM

| TypeRedis          | Redis                                                                                 | Valkey                                                                     |
|------------------------|---------------------------------------------------------------------------------------|----------------------------------------------------------------------------|
| `xAck`                 | [XACK](https://redis.io/docs/latest/commands/xack/)                                   | [XACK](https://valkey.io/commands/xack/)                                   |
| `xAdd`                 | [XADD](https://redis.io/docs/latest/commands/xadd/)                                   | [XADD](https://valkey.io/commands/xadd/)                                   |
| `xAutoClaim`           | [XAUTOCLAIM](https://redis.io/docs/latest/commands/xautoclaim/)                       | [XAUTOCLAIM](https://valkey.io/commands/xautoclaim/)                       |
| `xClaim`               | [XCLAIM](https://redis.io/docs/latest/commands/xclaim/)                               | [XCLAIM](https://valkey.io/commands/xclaim/)                               |
| `xDel`                 | [XDEL](https://redis.io/docs/latest/commands/xdel/)                                   | [XDEL](https://valkey.io/commands/xdel/)                                   |
| `xGroup`               | [XGROUP](https://redis.io/docs/latest/commands/xgroup/)                               | [XGROUP](https://valkey.io/commands/xgroup/)                               |
| `xGroupCreate`         | [XGROUP CREATE](https://redis.io/docs/latest/commands/xgroup-create/)                 | [XGROUP CREATE](https://valkey.io/commands/xgroup-create/)                 |
| `xGroupCreateConsumer` | [XGROUP CREATECONSUMER](https://redis.io/docs/latest/commands/xgroup-createconsumer/) | [XGROUP CREATECONSUMER](https://valkey.io/commands/xgroup-createconsumer/) |
| `xGroupDelConsumer`    | [XGROUP DELCONSUMER](https://redis.io/docs/latest/commands/xgroup-delconsumer/)       | [XGROUP DELCONSUMER](https://valkey.io/commands/xgroup-delconsumer/)       |
| `xGroupDestroy`        | [XGROUP DESTROY](https://redis.io/docs/latest/commands/xgroup-destroy/)               | [XGROUP DESTROY](https://valkey.io/commands/xgroup-destroy/)               |
| `xGroupHelp`           | [XGROUP HELP](https://redis.io/docs/latest/commands/xgroup-help/)                     | [XGROUP HELP](https://valkey.io/commands/xgroup-help/)                     |
| `xGroupSetId`          | [XGROUP SETID](https://redis.io/docs/latest/commands/xgroup-setid/)                   | [XGROUP SETID](https://valkey.io/commands/xgroup-setid/)                   |
| `xInfo`                | [XINFO](https://redis.io/docs/latest/commands/xinfo/)                                 | [XINFO](https://valkey.io/commands/xinfo/)                                 |
| `xInfoConsumers`       | [XINFO CONSUMERS](https://redis.io/docs/latest/commands/xinfo-consumers/)             | [XINFO CONSUMERS](https://valkey.io/commands/xinfo-consumers/)             |
| `xInfoGroups`          | [XINFO GROUPS](https://redis.io/docs/latest/commands/xinfo-groups/)                   | [XINFO GROUPS](https://valkey.io/commands/xinfo-groups/)                   |
| `xInfoHelp`            | [XINFO HELP](https://redis.io/docs/latest/commands/xinfo-help/)                       | [XINFO HELP](https://valkey.io/commands/xinfo-help/)                       |
| `xInfoStream`          | [XINFO STREAM](https://redis.io/docs/latest/commands/xinfo-stream/)                   | [XINFO STREAM](https://valkey.io/commands/xinfo-stream/)                   |
| `xLen`                 | [XLEN](https://redis.io/docs/latest/commands/xlen/)                                   | [XLEN](https://valkey.io/commands/xlen/)                                   |
| `xPending`             | [XPENDING](https://redis.io/docs/latest/commands/xpending/)                           | [XPENDING](https://valkey.io/commands/xpending/)                           |
| `xRange`               | [XRANGE](https://redis.io/docs/latest/commands/xrange/)                               | [XRANGE](https://valkey.io/commands/xrange/)                               |
| `xRead`                | [XREAD](https://redis.io/docs/latest/commands/xread/)                                 | [XREAD](https://valkey.io/commands/xread/)                                 |
| `xReadGroup`           | [XREADGROUP](https://redis.io/docs/latest/commands/xreadgroup/)                       | [XREADGROUP](https://valkey.io/commands/xreadgroup/)                       |
| `xRevRange`            | [XREVRANGE](https://redis.io/docs/latest/commands/xrevrange/)                         | [XREVRANGE](https://valkey.io/commands/xrevrange/)                         |
| `xSetId`               | [XSETID](https://redis.io/docs/latest/commands/xsetid/)                               | [XSETID](https://valkey.io/commands/xsetid/)                               |
| `xTrim`                | [XTRIM](https://redis.io/docs/latest/commands/xtrim/)                                 | [XTRIM](https://valkey.io/commands/xtrim/)                                 |