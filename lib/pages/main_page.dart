import 'dart:developer';
import 'dart:ui';
//Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import '../models/movie_model.dart';
import '../models/search_category.dart';
import '../models/main_page_data.dart';

// Widgets
import '../widgets/movie_list_view_item.dart';

// Controllers
import '../controllers/main_page_data_controller.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>((ref) {
  return MainPageDataController();
});

final selectedMoviePosterURLProvider = StateProvider<String?>((ref) {
  final movies = ref.watch(mainPageDataControllerProvider).movies!;
  return movies.isNotEmpty ? movies[0].posterUrl() : null;
});

class MainPage extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWeight;

  late TextEditingController searchTextFieldController;

  late MainPageDataController mainPageDataController;
  late MainPageData mainPageData;

  late var _selectedMoviePosterURL;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWeight = MediaQuery.of(context).size.width;
    searchTextFieldController = TextEditingController();

    mainPageDataController = ref.watch(mainPageDataControllerProvider.notifier);
    mainPageData = ref.watch(mainPageDataControllerProvider);

    searchTextFieldController.text = mainPageData.searchText ?? '';

    _selectedMoviePosterURL = ref.watch(selectedMoviePosterURLProvider);

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        height: deviceHeight,
        width: deviceWeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _forgroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return _selectedMoviePosterURL != null
        ? Container(
            height: deviceHeight,
            width: deviceWeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(_selectedMoviePosterURL),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _forgroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.05, 0, 0),
      width: deviceWeight * .88,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _topBarWidgt(),
          // _movieListViewItemWidget(),
          Container(
            height: deviceHeight * .83,
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: _movieListViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget _movieListViewWidget() {
    final List<MovieModel> movies = mainPageData.movies!;

    if (movies.isNotEmpty) {
      return NotificationListener(
        onNotification: (onScrollNotification) {
          if (onScrollNotification is ScrollEndNotification) {
            final before = onScrollNotification.metrics.extentBefore;
            final max = onScrollNotification.metrics.maxScrollExtent;

            if (before == max) {
              mainPageDataController.getMovies();
              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
            itemCount: movies.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                child: InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    _selectedMoviePosterURL = movies[index].posterUrl();
                  },
                  child: MovieListViewItem(
                    deviceHeight: deviceHeight,
                    deviceWeight: deviceWeight,
                    movie: movies[index],
                  ),
                ),
              );
            }),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      );
    }
  }

  Widget _topBarWidgt() {
    return Container(
      height: deviceHeight * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black54,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _searchFieldWidget(),
          _categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    const border = InputBorder.none;
    return SizedBox(
      height: deviceHeight * 0.05,
      width: deviceWeight * .50,
      child: TextField(
        controller: searchTextFieldController,
        onSubmitted: (input) {
          mainPageDataController.updateSearchText(searchText: input);
        },
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white24,
          ),
          hintStyle: TextStyle(color: Colors.white54),
          filled: false,
          fillColor: Colors.white24,
          hintText: 'Search....',
        ),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: mainPageData.searchCategory,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      items: const [
        DropdownMenuItem(
          value: SearchCategory.popular,
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upComing,
          child: Text(
            SearchCategory.upComing,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.none,
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      onChanged: (value) => value.toString().isNotEmpty
          ? mainPageDataController.updateSearchCategory(category: value!)
          : null,
    );
  }
}
