import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/movie_model.dart';

class MovieListViewItem extends StatelessWidget {
  MovieListViewItem(
      {super.key,
      required this.deviceHeight,
      required this.deviceWeight,
      required this.movie});

  final GetIt getIt = GetIt.instance;
  final double deviceHeight;
  final double deviceWeight;
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: deviceHeight * 0.2,
        width: deviceWeight * .88,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network(
              movie.posterUrl(),
            ),
            SizedBox(width: deviceWeight * .02),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.title ?? 'Unkown',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        movie.voteAverage.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  Text(
                    '${movie.originalLanguage} | R:${movie.adult} | ${movie.releaseDate}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: deviceHeight * 0.01),
                  Text(
                    movie.overview ?? ' non Description',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
