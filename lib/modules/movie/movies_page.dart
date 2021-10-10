import 'package:app_movies/modules/movie/movies_controller.dart';
import 'package:app_movies/modules/movie/widgets/movie_header.dart';
import 'package:app_movies/modules/movie/widgets/movies_filters.dart';
import 'package:app_movies/modules/movie/widgets/movies_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesPage extends GetView<MovieController> {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const MovieHeader(),
          const MoviesFilters(),
          MoviesGroup(
            title: 'Mais Populares',
            movies: controller.popularMovies,
          ),
          MoviesGroup(
            title: 'Top filmes',
            movies: controller.topRatedMovies,
          ),
        ],
      ),
    );
  }
}