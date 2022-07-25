import 'package:either_dart/either.dart';
import 'package:pokemon/domain/entity/location.dart';

import 'package:pokemon/domain/entity/pokemon_detail.dart';
import 'package:pokemon/domain/entity/pokemon_list.dart';
import 'package:pokemon/utils/failure.dart';

abstract class PokemonListDetailRepo {
  Future<Either<Failure, PokemonList>> getPokemonList(
      {int limit = 20, offset = 0});
  Future<Either<Failure, PokemonDetail>> getPokemonDetail({int id = 1});
  @override
  Future<Either<Failure, List<Location>>> getPokemonLocations({int id = 1});
}
