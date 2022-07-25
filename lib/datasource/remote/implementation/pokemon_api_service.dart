import 'package:either_dart/either.dart';
import 'package:pokemon/data/datasource/pokemon_data_source.dart';
import 'package:pokemon/datasource/dto/location_dto.dart';
import 'package:pokemon/datasource/dto/pokemon_detail_response_dto.dart';
import 'package:pokemon/datasource/dto/pokemon_list_response_dto.dart';
import 'package:pokemon/datasource/remote/api_service.dart';
import 'package:pokemon/utils/failure.dart';

class PokemonApiService implements PokemonDataSource {
  late ApiService _apiService;
  PokemonApiService({required ApiService apiService})
      : _apiService = apiService;
  @override
  Future<Either<Failure, PokemonDetailResponseDto>> getPokemonDetail(
      {int id = 1}) async {
    final response = await _apiService.getRequest(subUrl: "/pokemon/$id/");
    try {
      if (response.statusCode == 200) {
        return Right(PokemonDetailResponseDto.fromMap(response.data));
      } else {
        return Left(Failure("Something Went Wrong"));
      }
    } catch (e) {
      print(e);
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PokemonListResponseDto>> getPokemonList(
      {int limit = 20, offset = 0}) async {
    final response = await _apiService.getRequest(
        subUrl: "/pokemon/", queryParams: {"limit": limit, "offset": offset});
    try {
      if (response.statusCode == 200) {
        return Right(PokemonListResponseDto.fromMap(response.data));
      } else {
        return Left(Failure("Something Went Wrong"));
      }
    } catch (e) {
      print(e);
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LocationResponseDto>>> getPokemonLocations(
      {int id = 1}) async {
    final response =
        await _apiService.getRequest(subUrl: "/pokemon/$id/encounters");
    try {
      if (response.statusCode == 200) {
        return Right(LocationResponseDto.fromList(response.data as List));
      } else {
        return Left(Failure("Something Went Wrong"));
      }
    } catch (e) {
      print(e);
      return Left(Failure(e.toString()));
    }
  }
}
