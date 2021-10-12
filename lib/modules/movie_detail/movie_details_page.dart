import 'package:app_movies/modules/movie_detail/movie_details_controller.dart';
import 'package:app_movies/modules/movie_detail/widgets/movie_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/movie_detail_header.dart';

class MovieDetailsPage extends GetView<MovieDetailsController> {
  const MovieDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.movie.value?.title ?? 'Detalhes:')),
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
          child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieDetailHeader(movie: controller.movie.value),
            MovieDetailContent(movie: controller.movie.value),
          ],
        ),
      )),
    );
  }
}
