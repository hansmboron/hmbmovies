import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/modules/movie_detail/movie_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailHeader extends GetView<MovieDetailsController> {
  const MovieDetailHeader({Key? key, required this.movie}) : super(key: key);

  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    if (movie != null) {
      return SizedBox(
        height: 278,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movie!.urlImages.length,
          itemBuilder: (context, index) {
            final image = movie!.urlImages[index];
            return Padding(
              padding: const EdgeInsets.all(2),
              child: Image.network(image),
            );
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
