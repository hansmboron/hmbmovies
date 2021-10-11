import 'package:app_movies/application/ui/widgets/movie_card.dart';
import 'package:app_movies/modules/favorite/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meus Favoritos'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => SizedBox(
              width: Get.width,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: controller.movies
                    .map((m) => MovieCard(
                          movie: m,
                          favoriteCallback: () => controller.removeFavorite(m),
                        ))
                    .toList(),
              ),
            ),
          )),
    );
  }
}
