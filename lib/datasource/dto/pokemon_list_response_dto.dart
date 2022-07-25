import 'dart:convert';

class PokemonListResponseDto {
  PokemonListResponseDto({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic previous;
  List<ResultDto>? results;

  factory PokemonListResponseDto.fromJson(String str) =>
      PokemonListResponseDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonListResponseDto.fromMap(Map<String, dynamic> json) =>
      PokemonListResponseDto(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? null
            : List<ResultDto>.from(
                json["results"].map((x) => ResultDto.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class ResultDto {
  ResultDto({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory ResultDto.fromJson(String str) => ResultDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResultDto.fromMap(Map<String, dynamic> json) => ResultDto(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}
