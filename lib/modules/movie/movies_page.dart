import 'package:app_movies/modules/movie/widgets/movie_header.dart';
import 'package:app_movies/modules/movie/widgets/movies_filters.dart';
import 'package:flutter/material.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          MovieHeader(),
          MoviesFilters(),
        ],
      ),
    );
  }
}
