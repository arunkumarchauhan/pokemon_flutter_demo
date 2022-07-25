import 'dart:convert';

class PokemonList {
  PokemonList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic previous;
  List<PokemonListItem>? results;

  factory PokemonList.fromJson(String str) =>
      PokemonList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonList.fromMap(Map<String, dynamic> json) => PokemonList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? null
            : List<PokemonListItem>.from(
                json["results"].map((x) => PokemonListItem.fromMap(x))),
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

class PokemonListItem {
  PokemonListItem({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory PokemonListItem.fromJson(String str) =>
      PokemonListItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonListItem.fromMap(Map<String, dynamic> json) => PokemonListItem(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}
