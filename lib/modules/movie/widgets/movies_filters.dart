import 'package:app_movies/modules/movie/movies_controller.dart';
import 'package:app_movies/modules/movie/widgets/filter_tag.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class MoviesFilters extends GetView<MovieController> {
  const MoviesFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => Row(
              children: controller.genres
                  .map(
                    (g) => FilterTag(
                      model: g,
                      onPressed: () => controller.filterMoviesByGenre(g),
                      selected: controller.genreSelected.value?.id == g.id,
                    ),
                  )
                  .toList(),
            ),
          )),
    );
  }
}
