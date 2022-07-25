import 'package:pokemon/datasource/dto/location_dto.dart';
import 'package:pokemon/datasource/dto/pokemon_detail_response_dto.dart';
import 'package:pokemon/datasource/dto/pokemon_list_response_dto.dart';
import 'package:pokemon/domain/entity/location.dart';
import 'package:pokemon/domain/entity/pokemon_detail.dart';
import 'package:pokemon/domain/entity/pokemon_list.dart';

extension PokemonListDtoToEntity on PokemonListResponseDto {
  PokemonList mapToEntity() {
    return PokemonList.fromMap(toMap());
  }
}

extension PokemonDetailDtoToEntity on PokemonDetailResponseDto {
  PokemonDetail mapToEntity() {
    return PokemonDetail.fromMap(toMap());
  }
}

extension LocatonListDtoToEntity on List<LocationResponseDto> {
  List<Location> mapToEntity() {
    return List<Location>.from(map((e) => Location.fromMap(e.toMap())));
  }
}
