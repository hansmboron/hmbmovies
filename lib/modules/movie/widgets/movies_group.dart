import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:app_movies/modules/movie/movies_controller.dart';
import 'package:flutter/material.dart';

import 'package:app_movies/application/ui/widgets/movie_card.dart';
import 'package:app_movies/models/movie_model.dart';
import 'package:get/state_manager.dart';

class MoviesGroup extends GetView<MovieController> {
  final String title;
  final List<MovieModel> movies;
  final VoidCallback? onPressed;

  const MoviesGroup({
    Key? key,
    required this.title,
    required this.movies,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed != null
                  ? TextButton(
                      onPressed: onPressed,
                      child: Text(
                        'Fechar',
                        style: TextStyle(
                            color: context.themeRed,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        SizedBox(
            height: 250,
            child: Obx(
              () => ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var movie = movies[index];
                  controller.handleScrollWithIndex(index);
                  return MovieCard(
                    isAdmin: controller.isAdmin.value,
                    movie: movie,
                    favoriteCallback: () => controller.favoriteMovie(movie),
                    addToRec: () => controller.addToRec(movie),
                  );
                },
                itemCount: movies.length,
              ),
            )),
      ],
    );
  }
}
