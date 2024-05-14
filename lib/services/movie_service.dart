//Packages
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Models
import 'package:flickd_app/models/movie_model.dart';

//Services
import '../services/http_service.dart';

class MovieServics {
  final GetIt getIt = GetIt.instance;

  late HttpService httpService;

  MovieServics() {
    httpService = getIt.get<HttpService>();
  }

  Future<List<MovieModel>> getPopularMovies({int? page}) async {
    Response? response = await httpService.get('/movie/popular', query: {
      "page": page,
    });

    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<MovieModel> movies = data['results'].map<MovieModel>((movieData) {
        return MovieModel.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Could not load popular movies');
    }
  }

  Future<List<MovieModel>> getUpComingMovies({int? page}) async {
    Response? response = await httpService.get('/movie/upcoming', query: {
      "page": page,
    });

    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<MovieModel> movies = data['results'].map<MovieModel>((movieData) {
        return MovieModel.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Could not load Upcoming movies');
    }
  }

  Future<List<MovieModel>> searchMovie(String searchTerm, {int? page}) async {
    Response? response = await httpService.get('/search/movie', query: {
      "page": page,
      "query": searchTerm,
    });

    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<MovieModel> movies = data['results'].map<MovieModel>((movieData) {
        return MovieModel.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Could not load Searh movies');
    }
  }
}
