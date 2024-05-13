import 'dart:ui';
//Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Models
import '../models/movie_model.dart';
import '../models/search_category.dart';

// Widgets
import '../widgets/movie_list_view_item.dart';

class MainPage extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWeight;

  late TextEditingController searchTextFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWeight = MediaQuery.of(context).size.width;
    searchTextFieldController = TextEditingController();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
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
    return Container(
      height: deviceHeight,
      width: deviceWeight,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://i.ebayimg.com/images/g/rTUAAOSwFaRkfzZ8/s-l1200.jpg'),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
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
    final List<MovieModel> movies = [];
    for (var i = 0; i < 10; i++) {
      movies.add(MovieModel(
        title: 'Test Test',
        adult: true,
        voteAverage: 5.3,
        overview: 'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
        releaseDate: '2022-01-01',
      ));
    }
    if (movies.isNotEmpty) {
      return ListView.builder(
          itemCount: movies.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
              child: MovieListViewItem(
                deviceHeight: deviceHeight,
                deviceWeight: deviceWeight,
                movie: movies[index],
              ),
            );
          });
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
        onSubmitted: (input) {},
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
      value: SearchCategory.popular,
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
            )),
      ],
      onChanged: (value) {},
    );
  }
}
