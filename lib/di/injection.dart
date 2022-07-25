import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/data/repositories/pokemon_repo.dart';
import 'package:pokemon/datasource/remote/api_service.dart';
import 'package:pokemon/datasource/remote/implementation/pokemon_api_service.dart';
import 'package:pokemon/domain/entity/pokemon_list.dart';
import 'package:pokemon/domain/usecases/get_pokemon_detail_usecase.dart';
import 'package:pokemon/domain/usecases/get_pokemon_encounters_usecase.dart';
import 'package:pokemon/domain/usecases/get_pokemon_list_usecase.dart';
import 'package:pokemon/presentation/pokemons/controller/pokemon_list.dart';
import 'package:pokemon/utils/failure.dart';

final kDioProvider = Provider((ref) => Dio());
final kApiService = Provider((ref) => ApiService(dio: ref.read(kDioProvider)));
final kPokemonApiService =
    Provider((ref) => PokemonApiService(apiService: ref.read(kApiService)));

final kPokemonRepo = Provider((ref) =>
    PokemonRepoImplementation(apiService: ref.read(kPokemonApiService)));

final kPokemonListUseCase = Provider((ref) =>
    GetPokemonListUseCase(pokemonListDetailRepo: ref.read(kPokemonRepo)));

final kPokemonDetailUseCase = Provider((ref) =>
    GetPokemonDetailUseCase(pokemonListDetailRepo: ref.read(kPokemonRepo)));

final kPokemonListControllerProvider = Provider<PokemonListController>((ref) =>
    PokemonListController(
        getPokemonListUseCase: ref.read(kPokemonListUseCase)));
final kPokemonListControllerStateProvider = StateNotifierProvider<
    PokemonListController,
    AsyncValue<Either<Failure, List<PokemonListItem>>>>((ref) {
  return ref.watch(kPokemonListControllerProvider);
});

final kPokemonEncounterUseCaseProvider = Provider((ref) =>
    GetPokemonEncountersUseCase(pokemonListDetailRepo: ref.read(kPokemonRepo)));
