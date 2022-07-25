import 'dart:convert';

class LocationResponseDto {
  LocationResponseDto({
    this.locationArea,
    this.versionDetails,
  });

  LocationAreaDto? locationArea;
  List<VersionDetailDto>? versionDetails;

  factory LocationResponseDto.fromJson(String str) =>
      LocationResponseDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<LocationResponseDto> fromList(List list) {
    return List<LocationResponseDto>.from(list
        .map((e) => LocationResponseDto.fromMap(e as Map<String, dynamic>)));
  }

  factory LocationResponseDto.fromMap(Map<String, dynamic> json) {
    return LocationResponseDto(
      locationArea: LocationAreaDto.fromMap(json["location_area"] ?? {}),
      // versionDetails: json["version_details"] == null
      //     ? null
      //     : List<VersionDetailDto>.from(json["version_details"] ??
      //         [].map((x) {
      //           print("HERE ${x}");
      //           return VersionDetailDto.fromMap(x ?? {});
      //         })),
    );
  }

  Map<String, dynamic> toMap() => {
        "location_area": locationArea?.toMap(),
        // "version_details":
        //     List<dynamic>.from(versionDetails ?? [].map((x) => x.toMap())),
      };
}

class LocationAreaDto {
  LocationAreaDto({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory LocationAreaDto.fromJson(String str) =>
      LocationAreaDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationAreaDto.fromMap(Map<String, dynamic> json) => LocationAreaDto(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class VersionDetailDto {
  VersionDetailDto({
    this.encounterDetails,
    this.maxChance,
    this.version,
  });

  List<EncounterDetailDto>? encounterDetails;
  int? maxChance;
  LocationAreaDto? version;

  factory VersionDetailDto.fromJson(String str) =>
      VersionDetailDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VersionDetailDto.fromMap(Map<String, dynamic> json) {
    return VersionDetailDto(
      encounterDetails: json["encounter_details"] == null
          ? null
          : List<EncounterDetailDto>.from(json["encounter_details"]
              .map((x) => EncounterDetailDto.fromMap(x))),
      maxChance: json["max_chance"],
      version: LocationAreaDto.fromMap(json["version"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "encounter_details": encounterDetails == null
            ? null
            : List<dynamic>.from(encounterDetails!.map((x) => x.toMap())),
        "max_chance": maxChance,
        "version": version?.toMap(),
      };
}

class EncounterDetailDto {
  EncounterDetailDto({
    this.chance,
    this.conditionValues,
    this.maxLevel,
    this.method,
    this.minLevel,
  });

  int? chance;
  List<dynamic>? conditionValues;
  int? maxLevel;
  LocationAreaDto? method;
  int? minLevel;

  factory EncounterDetailDto.fromJson(String str) =>
      EncounterDetailDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EncounterDetailDto.fromMap(Map<String, dynamic> json) =>
      EncounterDetailDto(
        chance: json["chance"],
        conditionValues:
            List<dynamic>.from(json["condition_values"] ?? [].map((x) => x)),
        maxLevel: json["max_level"],
        method: LocationAreaDto.fromMap(json["method"] ?? {}),
        minLevel: json["min_level"],
      );

  Map<String, dynamic> toMap() => {
        "chance": chance,
        "condition_values":
            List<dynamic>.from(conditionValues ?? [].map((x) => x)),
        "max_level": maxLevel,
        "method": method?.toMap(),
        "min_level": minLevel,
      };
}
