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

import '../commands.dart' show Commands;

export 'extensions.dart';

mixin GeospatialIndicesCommands on Commands {}

/// Helper class for GeoLocation points
class GeoLocation {
  final double longitude;
  final double latitude;
  final String member;

  GeoLocation({
    required this.longitude,
    required this.latitude,
    required this.member,
  });
}

typedef GeoRadiusOptions = GeoSearchOptions;

/// Helper class for GeoSearch (R620+, and legacy GeoRadius) options
class GeoSearchOptions {
  final bool withCoord;
  final bool withDist;
  final bool withHash;
  final int? count;
  final bool? any; // Used with count
  final String? sort; // ASC or DESC

  const GeoSearchOptions({
    this.withCoord = false,
    this.withDist = false,
    this.withHash = false,
    this.count,
    this.any,
    this.sort,
  });
}
