// models
import 'package:flickd_app/models/search_category.dart';

import 'movie_model.dart';

class MainPageData {
  final List<MovieModel>? movies;
  final int? page;
  final String? searchCategory;
  final String? searchText;

  MainPageData({
    this.movies,
    this.page,
    this.searchCategory,
    this.searchText,
  });

  MainPageData.inital()
      : movies = [],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = '';

  MainPageData copyWith({
    List<MovieModel>? movies,
    int? page,
    String? searchText,
    String? searchCategory,
  }) {
    return MainPageData(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
    );
  }
}
