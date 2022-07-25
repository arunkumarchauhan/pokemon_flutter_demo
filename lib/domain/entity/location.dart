import 'dart:convert';

class Location {
  Location({
    this.locationArea,
    // this.versionDetails,
  });

  LocationArea? locationArea;
  // List<VersionDetail>? versionDetails;

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        locationArea: LocationArea.fromMap(json["location_area"] ?? {}),
        // versionDetails: List<VersionDetail>.from(
        //     json["version_details"] ?? [].map((x) => VersionDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "location_area": locationArea?.toMap(),
        // "version_details":
        //     List<dynamic>.from(versionDetails ?? [].map((x) => x.toMap())),
      };
}

class LocationArea {
  LocationArea({
    this.name,
  });

  String? name;

  factory LocationArea.fromJson(String str) =>
      LocationArea.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationArea.fromMap(Map<String, dynamic> json) => LocationArea(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}

class VersionDetail {
  VersionDetail({
    this.maxChance,
    this.version,
  });

  int? maxChance;
  LocationArea? version;

  factory VersionDetail.fromJson(String str) =>
      VersionDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VersionDetail.fromMap(Map<String, dynamic> json) => VersionDetail(
        maxChance: json["max_chance"],
        version: LocationArea.fromMap(json["version"]),
      );

  Map<String, dynamic> toMap() => {
        "max_chance": maxChance,
        "version": version?.toMap(),
      };
}
