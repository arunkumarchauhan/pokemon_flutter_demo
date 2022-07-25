import 'package:either_dart/either.dart';
import 'package:pokemon/domain/entity/pokemon_detail.dart';
import 'package:pokemon/utils/failure.dart';

import '../repositories/pokemon_repository.dart';

class GetPokemonDetailUseCase {
  late PokemonListDetailRepo _repo;
  GetPokemonDetailUseCase(
      {required PokemonListDetailRepo pokemonListDetailRepo})
      : _repo = pokemonListDetailRepo;
  Future<Either<Failure, PokemonDetail>> get({int id = 1}) {
    return _repo.getPokemonDetail(id: id);
  }
}
