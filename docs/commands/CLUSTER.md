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

# CLUSTER

`clusterSlots`, `asking`

| keyscope_client               | Redis                                                                                                 | Valkey                                                                                     |
|-------------------------------|-------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|
| `asking`                      | [ASKING](https://redis.io/docs/latest/commands/asking/)                                               | [ASKING](https://valkey.io/commands/asking/)                                               |
| `cluster`                     | [CLUSTER](https://redis.io/docs/latest/commands/cluster/)                                             | [CLUSTER](https://valkey.io/commands/cluster/)                                             |
| `clusterAddSlots`             | [CLUSTER ADDSLOTS](https://redis.io/docs/latest/commands/cluster-addslots/)                           | [CLUSTER ADDSLOTS](https://valkey.io/commands/cluster-addslots/)                           |
| `clusterAddSlotsRange`        | [CLUSTER ADDSLOTSRANGE](https://redis.io/docs/latest/commands/cluster-addslotsrange/)                 | [CLUSTER ADDSLOTSRANGE](https://valkey.io/commands/cluster-addslotsrange/)                 |
| `clusterBumpEpoch`            | [CLUSTER BUMPEPOCH](https://redis.io/docs/latest/commands/cluster-bumpepoch/)                         | [CLUSTER BUMPEPOCH](https://valkey.io/commands/cluster-bumpepoch/)                         |
| `clusterCancelSlotMigrations` | [CLUSTER CANCELSLOTMIGRATIONS](https://redis.io/docs/latest/commands/cluster-cancelslotmigrations/)   | [CLUSTER CANCELSLOTMIGRATIONS](https://valkey.io/commands/cluster-cancelslotmigrations/)   |
| `clusterCountFailureReports`  | [CLUSTER COUNT-FAILURE-REPORTS](https://redis.io/docs/latest/commands/cluster-count-failure-reports/) | [CLUSTER COUNT-FAILURE-REPORTS](https://valkey.io/commands/cluster-count-failure-reports/) |
| `clusterCountKeysInSlot`      | [CLUSTER COUNTKEYSINSLOT](https://redis.io/docs/latest/commands/cluster-countkeysinslot/)             | [CLUSTER COUNTKEYSINSLOT](https://valkey.io/commands/cluster-countkeysinslot/)             |
| `clusterDelSlots`             | [CLUSTER DELSLOTS](https://redis.io/docs/latest/commands/cluster-delslots/)                           | [CLUSTER DELSLOTS](https://valkey.io/commands/cluster-delslots/)                           |
| `clusterDelSlotsRange`        | [CLUSTER DELSLOTSRANGE](https://redis.io/docs/latest/commands/cluster-delslotsrange/)                 | [CLUSTER DELSLOTSRANGE](https://valkey.io/commands/cluster-delslotsrange/)                 |
| `clusterFailover`             | [CLUSTER FAILOVER](https://redis.io/docs/latest/commands/cluster-failover/)                           | [CLUSTER FAILOVER](https://valkey.io/commands/cluster-failover/)                           |
| `clusterFlushSlots`           | [CLUSTER FLUSHSLOTS](https://redis.io/docs/latest/commands/cluster-flushslots/)                       | [CLUSTER FLUSHSLOTS](https://valkey.io/commands/cluster-flushslots/)                       |
| `clusterForget`               | [CLUSTER FORGET](https://redis.io/docs/latest/commands/cluster-forget/)                               | [CLUSTER FORGET](https://valkey.io/commands/cluster-forget/)                               |
| `clusterGetKeysInSlot`        | [CLUSTER GETKEYSINSLOT](https://redis.io/docs/latest/commands/cluster-getkeysinslot/)                 | [CLUSTER GETKEYSINSLOT](https://valkey.io/commands/cluster-getkeysinslot/)                 |
| `clusterGetSlotMigrations`    | [CLUSTER GETSLOTMIGRATIONS](https://redis.io/docs/latest/commands/cluster-getslotmigrations/)         | [CLUSTER GETSLOTMIGRATIONS](https://valkey.io/commands/cluster-getslotmigrations/)         |
| `clusterHelp`                 | [CLUSTER HELP](https://redis.io/docs/latest/commands/cluster-help/)                                   | [CLUSTER HELP](https://valkey.io/commands/cluster-help/)                                   |
| `clusterInfo`                 | [CLUSTER INFO](https://redis.io/docs/latest/commands/cluster-info/)                                   | [CLUSTER INFO](https://valkey.io/commands/cluster-info/)                                   |
| `clusterKeySlot`              | [CLUSTER KEYSLOT](https://redis.io/docs/latest/commands/cluster-keyslot/)                             | [CLUSTER KEYSLOT](https://valkey.io/commands/cluster-keyslot/)                             |
| `clusterLinks`                | [CLUSTER LINKS](https://redis.io/docs/latest/commands/cluster-links/)                                 | [CLUSTER LINKS](https://valkey.io/commands/cluster-links/)                                 |
| `clusterMeet`                 | [CLUSTER MEET](https://redis.io/docs/latest/commands/cluster-meet/)                                   | [CLUSTER MEET](https://valkey.io/commands/cluster-meet/)                                   |
| `clusterMigrateSlots`         | [CLUSTER MIGRATESLOTS](https://redis.io/docs/latest/commands/cluster-migrateslots/)                   | [CLUSTER MIGRATESLOTS](https://valkey.io/commands/cluster-migrateslots/)                   |
| `clusterMyId`                 | [CLUSTER MYID](https://redis.io/docs/latest/commands/cluster-myid/)                                   | [CLUSTER MYID](https://valkey.io/commands/cluster-myid/)                                   |
| `clusterMyShardId`            | [CLUSTER MYSHARDID](https://redis.io/docs/latest/commands/cluster-myshardid/)                         | [CLUSTER MYSHARDID](https://valkey.io/commands/cluster-myshardid/)                         |
| `clusterNodes`                | [CLUSTER NODES](https://redis.io/docs/latest/commands/cluster-nodes/)                                 | [CLUSTER NODES](https://valkey.io/commands/cluster-nodes/)                                 |
| `clusterReplicas`             | [CLUSTER REPLICAS](https://redis.io/docs/latest/commands/cluster-replicas/)                           | [CLUSTER REPLICAS](https://valkey.io/commands/cluster-replicas/)                           |
| `clusterReplicate`            | [CLUSTER REPLICATE](https://redis.io/docs/latest/commands/cluster-replicate/)                         | [CLUSTER REPLICATE](https://valkey.io/commands/cluster-replicate/)                         |
| `clusterReset`                | [CLUSTER RESET](https://redis.io/docs/latest/commands/cluster-reset/)                                 | [CLUSTER RESET](https://valkey.io/commands/cluster-reset/)                                 |
| `clusterSaveConfig`           | [CLUSTER SAVECONFIG](https://redis.io/docs/latest/commands/cluster-saveconfig/)                       | [CLUSTER SAVECONFIG](https://valkey.io/commands/cluster-saveconfig/)                       |
| `clusterSetConfigEpoch`       | [CLUSTER SET-CONFIG-EPOCH](https://redis.io/docs/latest/commands/cluster-set-config-epoch/)           | [CLUSTER SET-CONFIG-EPOCH](https://valkey.io/commands/cluster-set-config-epoch/)           |
| `clusterSetSlot`              | [CLUSTER SETSLOT](https://redis.io/docs/latest/commands/cluster-setslot/)                             | [CLUSTER SETSLOT](https://valkey.io/commands/cluster-setslot/)                             |
| `clusterShards`               | [CLUSTER SHARDS](https://redis.io/docs/latest/commands/cluster-shards/)                               | [CLUSTER SHARDS](https://valkey.io/commands/cluster-shards/)                               |
| `clusterSlaves`               | [CLUSTER SLAVES](https://redis.io/docs/latest/commands/cluster-slaves/)                               | [CLUSTER SLAVES](https://valkey.io/commands/cluster-slaves/)                               |
| `clusterSlotStats`            | [CLUSTER SLOT-STATS](https://redis.io/docs/latest/commands/cluster-slot-stats/)                       | [CLUSTER SLOT-STATS](https://valkey.io/commands/cluster-slot-stats/)                       |
| `clusterSlots`                | [CLUSTER SLOTS](https://redis.io/docs/latest/commands/cluster-slots/)                                 | [CLUSTER SLOTS](https://valkey.io/commands/cluster-slots/)                                 |
| `clusterSyncSlots`            | [CLUSTER SYNCSLOTS](https://redis.io/docs/latest/commands/cluster-syncslots/)                         | [CLUSTER SYNCSLOTS](https://valkey.io/commands/cluster-syncslots/)                         |
| `readOnly`                    | [READONLY](https://redis.io/docs/latest/commands/readonly/)                                           | [READONLY](https://valkey.io/commands/readonly/)                                           |
| `readWrite`                   | [READWRITE](https://redis.io/docs/latest/commands/readwrite/)                                         | [READWRITE](https://valkey.io/commands/readwrite/)                                         |