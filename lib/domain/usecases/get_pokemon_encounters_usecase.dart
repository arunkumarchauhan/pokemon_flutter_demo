import 'package:either_dart/either.dart';
import 'package:pokemon/domain/entity/location.dart';
import 'package:pokemon/domain/entity/pokemon_detail.dart';
import 'package:pokemon/utils/failure.dart';

import '../repositories/pokemon_repository.dart';

class GetPokemonEncountersUseCase {
  late PokemonListDetailRepo _repo;
  GetPokemonEncountersUseCase(
      {required PokemonListDetailRepo pokemonListDetailRepo})
      : _repo = pokemonListDetailRepo;
  Future<Either<Failure, List<Location>>> get({int id = 1}) {
    return _repo.getPokemonLocations(id: id);
  }
}
