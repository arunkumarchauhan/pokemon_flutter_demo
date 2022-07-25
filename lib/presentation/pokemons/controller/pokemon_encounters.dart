import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/di/injection.dart';
import 'package:pokemon/domain/entity/location.dart';
import 'package:pokemon/presentation/pokemons/controller/pokemon_detail.dart';
import 'package:pokemon/utils/failure.dart';

final kPokemonEncountersFetchStatusProvider =
    StateProvider((ref) => Status.loading);

final kEncountersProvider = FutureProvider.family
    .autoDispose<Either<Failure, List<Location>>, int>((ref, int id) async {
  final statusProvider =
      ref.read(kPokemonEncountersFetchStatusProvider.notifier);
  statusProvider.state = Status.loading;
  final useCase = ref.read(kPokemonEncounterUseCaseProvider);
  statusProvider.state = Status.loaded;
  return await useCase.get(id: id);
});
