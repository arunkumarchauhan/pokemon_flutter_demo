import 'package:dio/dio.dart';

class ApiService {
  Dio _dio;
  ApiService({required Dio dio})
      : _dio = dio,
        super();
  String _url = "https://pokeapi.co/api/v2";
  Future<Response> getRequest(
      {String subUrl = "", Map<String, dynamic> queryParams = const {}}) async {
    String url = _url + subUrl;
    print(url);
    Response response = await _dio.get(url, queryParameters: queryParams);
    print("DATA : ${response.data.runtimeType}");

    return response;
  }
}
