import 'dart:convert';

class PokemonDetailResponseDto {
  PokemonDetailResponseDto({
    this.abilities,
    this.baseExperience,
    this.forms,
    this.gameIndices,
    this.height,
    this.heldItems,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.moves,
    this.name,
    this.order,
    this.pastTypes,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
  });

  List<AbilityDto>? abilities;
  int? baseExperience;
  List<SpeciesDto>? forms;
  List<GameIndexDto>? gameIndices;
  int? height;
  List<dynamic>? heldItems;
  int? id;
  bool? isDefault;
  String? locationAreaEncounters;
  List<MoveDto>? moves;
  String? name;
  int? order;
  List<dynamic>? pastTypes;
  SpeciesDto? species;
  SpritesDto? sprites;
  List<StatDto>? stats;
  List<TypeDto>? types;
  int? weight;

  factory PokemonDetailResponseDto.fromJson(String str) =>
      PokemonDetailResponseDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonDetailResponseDto.fromMap(Map<String, dynamic> json) =>
      PokemonDetailResponseDto(
        abilities: json["abilities"] == null
            ? null
            : List<AbilityDto>.from(
                json["abilities"].map((x) => AbilityDto.fromMap(x))),
        baseExperience: json["base_experience"],
        forms: json["forms"] == null
            ? null
            : List<SpeciesDto>.from(
                json["forms"].map((x) => SpeciesDto.fromMap(x))),
        gameIndices: json["game_indices"] == null
            ? null
            : List<GameIndexDto>.from(
                json["game_indices"].map((x) => GameIndexDto.fromMap(x))),
        height: json["height"],
        heldItems: json["held_items"] == null
            ? null
            : List<dynamic>.from(json["held_items"].map((x) => x)),
        id: json["id"],
        isDefault: json["is_default"],
        locationAreaEncounters: json["location_area_encounters"],
        moves: List<MoveDto>.from(json["moves"].map((x) => MoveDto.fromMap(x))),
        name: json["name"],
        order: json["order"],
        pastTypes: List<dynamic>.from(json["past_types"].map((x) => x)),
        species: SpeciesDto.fromMap(json["species"]),
        sprites: SpritesDto.fromMap(json["sprites"]),
        stats: List<StatDto>.from(json["stats"].map((x) => StatDto.fromMap(x))),
        types: List<TypeDto>.from(json["types"].map((x) => TypeDto.fromMap(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toMap() => {
        "abilities": abilities == null
            ? null
            : List<dynamic>.from(abilities!.map((x) => x.toMap())),
        "base_experience": baseExperience,
        "forms": forms == null
            ? null
            : List<dynamic>.from(forms!.map((x) => x.toMap())),
        "game_indices": gameIndices == null
            ? null
            : List<dynamic>.from(gameIndices!.map((x) => x.toMap())),
        "height": height,
        "held_items": heldItems == null
            ? null
            : List<dynamic>.from(heldItems!.map((x) => x)),
        "id": id,
        "is_default": isDefault,
        "location_area_encounters": locationAreaEncounters,
        "moves": moves == null
            ? null
            : List<dynamic>.from(moves!.map((x) => x.toMap())),
        "name": name,
        "order": order,
        "past_types": pastTypes == null
            ? null
            : List<dynamic>.from(pastTypes!.map((x) => x)),
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

class AbilityDto {
  AbilityDto({
    this.ability,
    this.isHidden,
    this.slot,
  });

  SpeciesDto? ability;
  bool? isHidden;
  int? slot;

  factory AbilityDto.fromJson(String str) =>
      AbilityDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbilityDto.fromMap(Map<String, dynamic> json) => AbilityDto(
        ability: SpeciesDto.fromMap(json["ability"] ?? const {}),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toMap() => {
        "ability": ability == null ? null : ability!.toMap(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class SpeciesDto {
  SpeciesDto({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory SpeciesDto.fromJson(String str) =>
      SpeciesDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpeciesDto.fromMap(Map<String, dynamic> json) => SpeciesDto(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class GameIndexDto {
  GameIndexDto({
    this.gameIndex,
    this.version,
  });

  int? gameIndex;
  SpeciesDto? version;

  factory GameIndexDto.fromJson(String str) =>
      GameIndexDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GameIndexDto.fromMap(Map<String, dynamic> json) => GameIndexDto(
        gameIndex: json["game_index"],
        version: SpeciesDto.fromMap(json["version"] ?? const {}),
      );

  Map<String, dynamic> toMap() => {
        "game_index": gameIndex,
        "version": version == null ? null : version!.toMap(),
      };
}

class MoveDto {
  MoveDto({
    this.move,
    this.versionGroupDetails,
  });

  SpeciesDto? move;
  List<VersionGroupDetailDto>? versionGroupDetails;

  factory MoveDto.fromJson(String str) => MoveDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MoveDto.fromMap(Map<String, dynamic> json) => MoveDto(
        move: SpeciesDto.fromMap(json["move"] ?? {}),
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
  SpeciesDto? moveLearnMethod;
  SpeciesDto? versionGroup;

  factory VersionGroupDetailDto.fromJson(String str) =>
      VersionGroupDetailDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VersionGroupDetailDto.fromMap(Map<String, dynamic> json) =>
      VersionGroupDetailDto(
        levelLearnedAt: json["level_learned_at"],
        moveLearnMethod: SpeciesDto.fromMap(json["move_learn_method"] ?? {}),
        versionGroup: SpeciesDto.fromMap(json["version_group"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "level_learned_at": levelLearnedAt,
        "move_learn_method":
            moveLearnMethod == null ? null : moveLearnMethod!.toMap(),
        "version_group": versionGroup == null ? null : versionGroup!.toMap(),
      };
}

class SpritesDto {
  SpritesDto({this.backDefault, this.backShiny, this.frontDefault, this.other});

  String? backDefault;
  String? backShiny;
  String? frontDefault;
  OtherDto? other;
  factory SpritesDto.fromJson(String str) =>
      SpritesDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpritesDto.fromMap(Map<String, dynamic> json) => SpritesDto(
        backDefault: json["back_default"],
        backShiny: json["back_shiny"],
        frontDefault: json["front_default"],
        other: json["other"] == null ? null : OtherDto.fromMap(json["other"]),
      );

  Map<String, dynamic> toMap() => {
        "back_default": backDefault,
        "back_shiny": backShiny,
        "front_default": frontDefault,
        "other": other?.toMap(),
      };
}

class OtherDto {
  OtherDto({
    this.home,
  });

  HomeDto? home;

  factory OtherDto.fromJson(String str) => OtherDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtherDto.fromMap(Map<String, dynamic> json) => OtherDto(
        home: HomeDto.fromMap(json["home"]),
      );

  Map<String, dynamic> toMap() => {
        "home": home?.toMap(),
      };
}

class HomeDto {
  HomeDto({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  factory HomeDto.fromJson(String str) => HomeDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeDto.fromMap(Map<String, dynamic> json) => HomeDto(
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

class StatDto {
  StatDto({
    this.baseStat,
    this.effort,
    this.stat,
  });

  int? baseStat;
  int? effort;
  SpeciesDto? stat;

  factory StatDto.fromJson(String str) => StatDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatDto.fromMap(Map<String, dynamic> json) => StatDto(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: SpeciesDto.fromMap(json["stat"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat == null ? null : stat!.toMap(),
      };
}

class TypeDto {
  TypeDto({
    this.slot,
    this.type,
  });

  int? slot;
  SpeciesDto? type;

  factory TypeDto.fromJson(String str) => TypeDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeDto.fromMap(Map<String, dynamic> json) => TypeDto(
        slot: json["slot"],
        type: SpeciesDto.fromMap(json["type"] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type == null ? null : type!.toMap(),
      };
}
