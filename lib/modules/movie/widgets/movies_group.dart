import 'package:flutter/material.dart';

import 'package:app_movies/application/ui/widgets/movie_card.dart';
import 'package:app_movies/models/movie_model.dart';
import 'package:get/state_manager.dart';

class MoviesGroup extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;

  const MoviesGroup({
    Key? key,
    required this.title,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
            height: 250,
            child: Obx(
              () => ListView.builder(
                itemCount: movies.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: movies[index],
                  );
                },
              ),
            )),
      ],
    );
  }
}
