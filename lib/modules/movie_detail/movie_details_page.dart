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
        title: Obx(
          () => Text(controller.movie.value?.title ?? 'Detalhes:'),
        ),
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          Obx(() => controller.isAdmin.value
              ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Get.defaultDialog(
                      onConfirm: () => controller.addTorrent(),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            autocorrect: false,
                            controller: controller.torrentCtrl,
                            decoration: const InputDecoration(
                              label: Text('Magnet link'),
                            ),
                          ),
                          TextField(
                            autocorrect: false,
                            controller: controller.trailerCtrl,
                            decoration: const InputDecoration(
                              label: Text('Youtube'),
                            ),
                          ),
                        ],
                      )),
                  icon: const Icon(Icons.add),
                )
              : Container())
        ],
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
