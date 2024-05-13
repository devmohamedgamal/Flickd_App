// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:developer';
//Models
import '../models/config.dart';

//Packages
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

class HttpService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _baseUrl;
  late String _api_key;

  HttpService() {
    AppConfig config = getIt.get<AppConfig>();
    _baseUrl = config.BASE_API_URL;
    _api_key = config.API_KEY;
  }

  Future<Response?> get(String _path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$_baseUrl$_path';
      Map<String, dynamic> _query = {
        'api_key': _api_key,
        'language': 'en-US',
      };
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(_url, queryParameters: _query);
    } on DioException catch (e) {
      log('dio ex --> $e');
      return null;
    }
  }
}
