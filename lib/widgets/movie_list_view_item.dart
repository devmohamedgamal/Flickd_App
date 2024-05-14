// Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Models
import '../models/movie_model.dart';

// Assets
import '../core/utils/assets_manger.dart';

class MovieListViewItem extends StatelessWidget {
  MovieListViewItem({
    super.key,
    required this.deviceHeight,
    required this.deviceWeight,
    required this.movie,
  });

  final GetIt getIt = GetIt.instance;
  final double deviceHeight;
  final double deviceWeight;
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * 0.2,
      width: deviceWeight * .88,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.network(
            movie.posterUrl(),
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(AssetsManger.error);
            },
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
                    SizedBox(
                      width: deviceWeight * .4,
                      child: Text(
                        movie.title ?? 'Unkown',
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Text(
                      movie.voteAverage?.toString() ?? '0.0',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                Text(
                  '${movie.originalLanguage?.toUpperCase() ?? 'none'} | R:${movie.adult ?? "false"} | ${movie.releaseDate ?? "unkown"}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(height: deviceHeight * 0.01),
                Text(
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  movie.overview ?? ' non Description',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
