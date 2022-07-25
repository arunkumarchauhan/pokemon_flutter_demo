import 'package:either_dart/either.dart';

import 'package:pokemon/datasource/remote/implementation/pokemon_api_service.dart';
import 'package:pokemon/domain/entity/location.dart';
import 'package:pokemon/domain/entity/pokemon_detail.dart';
import 'package:pokemon/domain/entity/pokemon_list.dart';
import 'package:pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokemon/utils/failure.dart';
import '../mapper/pokemon_mapper.dart';

class PokemonRepoImplementation implements PokemonListDetailRepo {
  late PokemonApiService _apiService;
  PokemonRepoImplementation({required PokemonApiService apiService})
      : _apiService = apiService;
  Future<Either<Failure, PokemonList>> getPokemonList(
      {int limit = 20, offset = 0}) async {
    final response =
        await _apiService.getPokemonList(limit: limit, offset: offset);
    try {
      if (response.isLeft) {
        return Left(response.left);
      } else {
        return Right(response.right.mapToEntity());
      }
    } catch (e) {
      print(e);
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, PokemonDetail>> getPokemonDetail({int id = 1}) async {
    final response = await _apiService.getPokemonDetail(id: id);
    try {
      if (response.isLeft) {
        return Left(response.left);
      } else {
        return Right(response.right.mapToEntity());
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> getPokemonLocations(
      {int id = 1}) async {
    final response = await _apiService.getPokemonLocations(id: id);
    try {
      if (response.isLeft) {
        return Left(response.left);
      } else {
        return Right(response.right.mapToEntity());
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
