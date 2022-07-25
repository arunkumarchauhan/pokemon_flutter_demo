import 'package:either_dart/either.dart';
import 'package:pokemon/domain/entity/pokemon_list.dart';
import 'package:pokemon/utils/failure.dart';

import '../repositories/pokemon_repository.dart';

class GetPokemonListUseCase {
  late PokemonListDetailRepo _repo;
  GetPokemonListUseCase({required PokemonListDetailRepo pokemonListDetailRepo})
      : _repo = pokemonListDetailRepo;
  Future<Either<Failure, PokemonList>> get({int limit = 20, int offset = 0}) {
    return _repo.getPokemonList(limit: limit, offset: offset);
  }
}
