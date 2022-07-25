import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/di/injection.dart';
import 'package:pokemon/domain/entity/location.dart';
import 'package:pokemon/domain/entity/pokemon_list.dart';
import 'package:pokemon/domain/usecases/get_pokemon_list_usecase.dart';
import 'package:pokemon/utils/failure.dart';

class PokemonListController
    extends StateNotifier<AsyncValue<Either<Failure, List<PokemonListItem>>>> {
  late GetPokemonListUseCase _useCase;
  bool isLoading = false;
  PokemonListController({required GetPokemonListUseCase getPokemonListUseCase})
      : _useCase = getPokemonListUseCase,
        super(const AsyncValue.loading());
  List<PokemonListItem> _pokemons = [];
  void getPokemonList() async {
    if (!isLoading) {
      isLoading = true;
      final response = await _useCase.get(limit: 20, offset: _pokemons.length);
      if (response.isLeft) {
        state = AsyncValue.error(Left(response.left));
      } else {
        if (response.right.results != null) {
          _pokemons.addAll(response.right.results!);
          state = AsyncValue.data(Right(_pokemons));
        } else {
          state = AsyncValue.error(Left(Failure("Data Problem")));
        }
      }
      isLoading = false;
    }
  }
}

final kGetPokemonEncounterLocationFutureProvider = FutureProvider.family
    .autoDispose<Either<Failure, List<Location>>, int>((ref, int id) {
  final kUseCaseProvider = ref.read(kPokemonEncounterUseCaseProvider);
  return kUseCaseProvider.get(id: id);
});
