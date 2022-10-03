import 'package:flutter/material.dart';

import 'package:movie_app/api_config/api_service.dart';
import 'package:movie_app/ui/movies_card.dart';
import 'package:movie_app/ui/skeleton_loading.dart';

class SimiliarMovies extends StatelessWidget {
  int movieId;
  SimiliarMovies({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService.getMoviesbyCat('similiar', id: movieId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return moviesCard(
                  category: 'similiar', movieData: snapshot, context: context);
            case ConnectionState.waiting:
              return skeletonCardLoader(movieData: snapshot);

            default:
              throw Exception('error');
          }
        });
  }
}
