import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/di/injection.dart';
import 'package:pokemon/domain/entity/pokemon_detail.dart';
import 'package:pokemon/domain/usecases/get_pokemon_detail_usecase.dart';
import 'package:pokemon/domain/usecases/get_pokemon_encounters_usecase.dart';
import 'package:pokemon/utils/failure.dart';
import 'package:pokemon/domain/entity/pokemon_list.dart';
import 'package:pokemon/domain/usecases/get_pokemon_list_usecase.dart';

enum Status { loading, failed, loaded }

final kPokemonDetailFetchStatusProvider =
    StateProvider.autoDispose<Status>((ref) => Status.loading);

final kPokemonDetailProvider = FutureProvider.family
    .autoDispose<Either<Failure, PokemonDetail>, int>((ref, int id) async {
  final statusProvider = ref.read(kPokemonDetailFetchStatusProvider.notifier);
  statusProvider.state = Status.loading;
  final useCase = ref.read(kPokemonDetailUseCase);
  final response = await useCase.get(id: id);
  statusProvider.state = Status.loaded;
  return response;
});

class PokemonDetailController
    extends StateNotifier<AsyncValue<Either<Failure, PokemonDetail>>> {
  late GetPokemonDetailUseCase _useCase;
  bool isLoading = false;
  PokemonDetailController(
      {required GetPokemonDetailUseCase getPokemonDetailUseCase})
      : _useCase = getPokemonDetailUseCase,
        super(const AsyncValue.loading());
  void getPokemonDetail({int id = 1}) async {
    final response = await _useCase.get(id: id);
    if (response.isLeft) {
      state = AsyncValue.error(Left(response.left));
    } else {
      state = AsyncValue.data(Right(response.right));
    }
  }
}

final kPokemonDetailControllerProvider = Provider((ref) =>
    PokemonDetailController(
        getPokemonDetailUseCase: ref.read(kPokemonDetailUseCase)));

final kPokemonDetailStateProvider = StateNotifierProvider<
        PokemonDetailController, AsyncValue<Either<Failure, PokemonDetail>>>(
    (ref) => ref.watch(kPokemonDetailControllerProvider));
