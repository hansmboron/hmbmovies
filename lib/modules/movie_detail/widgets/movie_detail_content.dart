import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/modules/movie_detail/widgets/content_credits.dart';
import 'package:app_movies/modules/movie_detail/widgets/content_main_cast.dart';
import 'package:app_movies/modules/movie_detail/widgets/content_production_companies.dart';
import 'package:app_movies/modules/movie_detail/widgets/content_title.dart';
import 'package:app_movies/modules/movie_detail/widgets/content_trailer.dart';
import 'package:flutter/material.dart';

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({Key? key, required this.movie}) : super(key: key);

  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentTitle(movie: movie),
          ContentCredits(movie: movie),
          movie?.youtube == null || movie?.youtube == ''
              ? Container()
              : ContentTrailer(movie: movie),
          ContentProductionCompanies(movie: movie),
          ContentMainCast(movie: movie),
        ],
      ),
    );
  }
}
