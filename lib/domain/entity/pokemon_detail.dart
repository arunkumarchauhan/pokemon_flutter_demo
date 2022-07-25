import 'dart:convert';

class PokemonDetail {
  PokemonDetail({
    this.abilities,
    this.baseExperience,
    this.height,
    this.id,
    this.locationAreaEncounters,
    this.moves,
    this.name,
    this.order,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
  });

  List<Ability>? abilities;
  int? baseExperience;
  int? height;
  int? id;
  String? locationAreaEncounters;
  List<Move>? moves;
  String? name;
  int? order;
  Species? species;
  Sprites? sprites;
  List<Stat>? stats;
  List<Type>? types;
  int? weight;

  factory PokemonDetail.fromJson(String str) =>
      PokemonDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonDetail.fromMap(Map<String, dynamic> json) => PokemonDetail(
        abilities: json["abilities"] == null
            ? null
            : List<Ability>.from(
                json["abilities"].map((x) => Ability.fromMap(x))),
        height: json["height"],
        id: json["id"],
        locationAreaEncounters: json["location_area_encounters"],
        moves: List<Move>.from(json["moves"].map((x) => Move.fromMap(x))),
        name: json["name"],
        order: json["order"],
        species: Species.fromMap(json["species"]),
        sprites: Sprites.fromMap(json["sprites"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromMap(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toMap() => {
        "abilities": abilities == null
            ? null
            : List<dynamic>.from(abilities!.map((x) => x.toMap())),
        "base_experience": baseExperience,
        "height": height,
        "id": id,
        "location_area_encounters": locationAreaEncounters,
        "moves": moves == null
            ? null
            : List<dynamic>.from(moves!.map((x) => x.toMap())),
        "name": name,
        "order": order,
        "species": species == null ? null : species!.toMap(),
        "sprites": species == null ? null : sprites!.toMap(),
        "stats": stats == null
            ? null
            : List<dynamic>.from(stats!.map((x) => x.toMap())),
        "types": types == null
            ? null
            : List<dynamic>.from(types!.map((x) => x.toMap())),
        "weight": weight,
      };
}

class Ability {
  Ability({
    this.ability,
    this.isHidden,
    this.slot,
  });

  Species? ability;
  bool? isHidden;
  int? slot;

  factory Ability.fromJson(String str) => Ability.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ability.fromMap(Map<String, dynamic> json) => Ability(
        ability: Species.fromMap(json["ability"] ?? const {}),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toMap() => {
        "ability": ability == null ? null : ability!.toMap(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class Species {
  Species({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Species.fromJson(String str) => Species.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Species.fromMap(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class Move {
  Move({
    this.move,
    this.versionGroupDetails,
  });

  Species? move;
  List<VersionGroupDetailDto>? versionGroupDetails;

  factory Move.fromJson(String str) => Move.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Move.fromMap(Map<String, dynamic> json) => Move(
        move: Species.fromMap(json["move"] ?? {}),
        versionGroupDetails: List<VersionGroupDetailDto>.from(
            json["version_group_details"]
                .map((x) => VersionGroupDetailDto.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "move": move == null ? null : move!.toMap(),
        "version_group_details": versionGroupDetails == null
            ? null
            : List<dynamic>.from(versionGroupDetails!.map((x) => x.toMap())),
      };
}

class VersionGroupDetailDto {
  VersionGroupDetailDto({
    this.levelLearnedAt,
    this.moveLearnMethod,
    this.versionGroup,
  });

  int? levelLearnedAt;
  Species? moveLearnMethod;
  Species? versionGroup;

  factory VersionGroupDetailDto.fromJson(String str) =>
      VersionGroupDetailDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VersionGroupDetailDto.fromMap(Map<String, dynamic> json) =>
      VersionGroupDetailDto(
        levelLearnedAt: json["level_learned_at"],
        moveLearnMethod: Species.fromMap(json["move_learn_method"] ?? {}),
        versionGroup: Species.fromMap(json["version_group"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "level_learned_at": levelLearnedAt,
        "move_learn_method":
            moveLearnMethod == null ? null : moveLearnMethod!.toMap(),
        "version_group": versionGroup == null ? null : versionGroup!.toMap(),
      };
}

class Sprites {
  Sprites({this.backDefault, this.backShiny, this.frontDefault, this.other});

  String? backDefault;
  String? backShiny;
  String? frontDefault;
  Other? other;
  factory Sprites.fromJson(String str) => Sprites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sprites.fromMap(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
        backShiny: json["back_shiny"],
        frontDefault: json["front_default"],
        other: Other.fromMap(json['other'] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "back_default": backDefault,
        "back_shiny": backShiny,
        "front_default": frontDefault,
        "other": other?.toMap(),
      };
}

class Other {
  Other({
    this.home,
  });

  Home? home;

  factory Other.fromJson(String str) => Other.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Other.fromMap(Map<String, dynamic> json) => Other(
        home: Home.fromMap(json["home"]),
      );

  Map<String, dynamic> toMap() => {
        "home": home?.toMap(),
      };
}

class Home {
  Home({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  factory Home.fromJson(String str) => Home.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Home.fromMap(Map<String, dynamic> json) => Home(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
      );

  Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}

class Stat {
  Stat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  int? baseStat;
  int? effort;
  Species? stat;

  factory Stat.fromJson(String str) => Stat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stat.fromMap(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromMap(json["stat"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat == null ? null : stat!.toMap(),
      };
}

class Type {
  Type({
    this.slot,
    this.type,
  });

  int? slot;
  Species? type;

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromMap(json["type"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type == null ? null : type!.toMap(),
      };
}
