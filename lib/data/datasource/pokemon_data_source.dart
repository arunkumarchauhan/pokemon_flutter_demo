import 'package:either_dart/either.dart';
import 'package:pokemon/datasource/dto/location_dto.dart';
import 'package:pokemon/datasource/dto/pokemon_detail_response_dto.dart';
import 'package:pokemon/datasource/dto/pokemon_list_response_dto.dart';
import 'package:pokemon/utils/failure.dart';

abstract class PokemonDataSource {
  Future<Either<Failure, PokemonListResponseDto>> getPokemonList(
      {int limit = 20, offset = 0});
  Future<Either<Failure, PokemonDetailResponseDto>> getPokemonDetail(
      {int id = 1});
  Future<Either<Failure, List<LocationResponseDto>>> getPokemonLocations(
      {int id});
}
