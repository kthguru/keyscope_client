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

# GENERIC

`del`, `exists`, `expire`, `scan`, `ttl`

| TypeRedis        | Redis                                                                     | Valkey                                                         |
|------------------|---------------------------------------------------------------------------|----------------------------------------------------------------|
| `copy`           | [COPY](https://redis.io/docs/latest/commands/copy/)                       | [COPY](https://valkey.io/commands/copy/)                       |
| `del`            | [DEL](https://redis.io/docs/latest/commands/del/)                         | [DEL](https://valkey.io/commands/del/)                         |
| `dump`           | [DUMP](https://redis.io/docs/latest/commands/dump/)                       | [DUMP](https://valkey.io/commands/dump/)                       |
| `exists`         | [EXISTS](https://redis.io/docs/latest/commands/exists/)                   | [EXISTS](https://valkey.io/commands/exists/)                   |
| `expire`         | [EXPIRE](https://redis.io/docs/latest/commands/expire/)                   | [EXPIRE](https://valkey.io/commands/expire/)                   |
| `expireAt`       | [EXPIREAT](https://redis.io/docs/latest/commands/expireat/)               | [EXPIREAT](https://valkey.io/commands/expireat/)               |
| `expireTime`     | [EXPIRETIME](https://redis.io/docs/latest/commands/expiretime/)           | [EXPIRETIME](https://valkey.io/commands/expiretime/)           |
| `keys`           | [KEYS](https://redis.io/docs/latest/commands/keys/)                       | [KEYS](https://valkey.io/commands/keys/)                       |
| `migrate`        | [MIGRATE](https://redis.io/docs/latest/commands/migrate/)                 | [MIGRATE](https://valkey.io/commands/migrate/)                 |
| `move`           | [MOVE](https://redis.io/docs/latest/commands/move/)                       | [MOVE](https://valkey.io/commands/move/)                       |
|                  | [OBJECT](https://redis.io/docs/latest/commands/object/)                   | [OBJECT](https://valkey.io/commands/object/)                   |
| `objectEncoding` | [OBJECT ENCODING](https://redis.io/docs/latest/commands/object-encoding/) | [OBJECT ENCODING](https://valkey.io/commands/object-encoding/) |
| `objectFreq`     | [OBJECT FREQ](https://redis.io/docs/latest/commands/object-freq/)         | [OBJECT FREQ](https://valkey.io/commands/object-freq/)         |
| `objectHelp`     | [OBJECT HELP](https://redis.io/docs/latest/commands/object-help/)         | [OBJECT HELP](https://valkey.io/commands/object-help/)         |
| `objectIdleTime` | [OBJECT IDLETIME](https://redis.io/docs/latest/commands/object-idletime/) | [OBJECT IDLETIME](https://valkey.io/commands/object-idletime/) |
| `objectRefCount` | [OBJECT REFCOUNT](https://redis.io/docs/latest/commands/object-refcount/) | [OBJECT REFCOUNT](https://valkey.io/commands/object-refcount/) |
| `persist`        | [PERSIST](https://redis.io/docs/latest/commands/persist/)                 | [PERSIST](https://valkey.io/commands/persist/)                 |
| `pExpire`        | [PEXPIRE](https://redis.io/docs/latest/commands/pexpire/)                 | [PEXPIRE](https://valkey.io/commands/pexpire/)                 |
| `pExpireAt`      | [PEXPIREAT](https://redis.io/docs/latest/commands/pexpireat/)             | [PEXPIREAT](https://valkey.io/commands/pexpireat/)             |
| `pExpireTime`    | [PEXPIRETIME](https://redis.io/docs/latest/commands/pexpiretime/)         | [PEXPIRETIME](https://valkey.io/commands/pexpiretime/)         |
| `pTtl`           | [PTTL](https://redis.io/docs/latest/commands/pttl/)                       | [PTTL](https://valkey.io/commands/pttl/)                       |
| `randomKey`      | [RANDOMKEY](https://redis.io/docs/latest/commands/randomkey/)             | [RANDOMKEY](https://valkey.io/commands/randomkey/)             |
| `rename`         | [RENAME](https://redis.io/docs/latest/commands/rename/)                   | [RENAME](https://valkey.io/commands/rename/)                   |
| `renameNx`       | [RENAMENX](https://redis.io/docs/latest/commands/renamenx/)               | [RENAMENX](https://valkey.io/commands/renamenx/)               |
| `restore`        | [RESTORE](https://redis.io/docs/latest/commands/restore/)                 | [RESTORE](https://valkey.io/commands/restore/)                 |
| `scan`           | [SCAN](https://redis.io/docs/latest/commands/scan/)                       | [SCAN](https://valkey.io/commands/scan/)                       |
| `sort`           | [SORT](https://redis.io/docs/latest/commands/sort/)                       | [SORT](https://valkey.io/commands/sort/)                       |
| `sortRo`         | [SORT_RO](https://redis.io/docs/latest/commands/sort_ro/)                 | [SORT_RO](https://valkey.io/commands/sort_ro/)                 |
| `touch`          | [TOUCH](https://redis.io/docs/latest/commands/touch/)                     | [TOUCH](https://valkey.io/commands/touch/)                     |
| `ttl`            | [TTL](https://redis.io/docs/latest/commands/ttl/)                         | [TTL](https://valkey.io/commands/ttl/)                         |
| `type`           | [TYPE](https://redis.io/docs/latest/commands/type/)                       | [TYPE](https://valkey.io/commands/type/)                       |
| `unlink`         | [UNLINK](https://redis.io/docs/latest/commands/unlink/)                   | [UNLINK](https://valkey.io/commands/unlink/)                   |
| `wait`           | [WAIT](https://redis.io/docs/latest/commands/wait/)                       | [WAIT](https://valkey.io/commands/wait/)                       |
| `waitAof`        | [WAITAOF](https://redis.io/docs/latest/commands/waitaof/)                 | [WAITAOF](https://valkey.io/commands/waitaof/)                 |