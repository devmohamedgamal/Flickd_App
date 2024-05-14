// Packages
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

// Models
import '../models/main_page_data.dart';
import '../models/movie_model.dart';
import '../models/search_category.dart';

// Services
import '../services/movie_service.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.inital()) {
    getMovies();
  }
  final MovieServics movieServics = GetIt.instance.get<MovieServics>();

  Future<void> getMovies() async {
    try {
      List<MovieModel> movies = [];

      if (state.searchText!.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          movies = await movieServics.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upComing) {
          movies = await movieServics.getUpComingMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.none) {
          movies = [];
        }
      } else {
        movies = await movieServics.searchMovie(state.searchText!);
      }
      state = state.copyWith(
        movies: [...state.movies!, ...movies],
        page: state.page! + 1,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void updateSearchCategory({required String category}) {
    try {
      state = state.copyWith(
          movies: [], searchCategory: category, searchText: '', page: 1);
      getMovies();
    } catch (e) {
      log(e.toString());
    }
  }

  void updateSearchText({required String searchText}) {
    try {
      state = state.copyWith(
          movies: [],
          page: 1,
          searchCategory: SearchCategory.none,
          searchText: searchText);
      getMovies();
    } catch (e) {
      log(e.toString());
    }
  }
}
