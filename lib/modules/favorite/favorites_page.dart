import 'package:app_movies/application/ui/widgets/ad_container.dart';
import 'package:app_movies/application/ui/widgets/movie_card.dart';
import 'package:app_movies/modules/favorite/favorites_controller.dart';
import 'package:app_movies/services/admob/admob_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _orientation = MediaQuery.of(context).orientation.index;
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
      bottomNavigationBar: _orientation == 1
          ? null
          : AdContainner(
              height: 60,
              ad: AdMobService.createBannerAd()..load(),
            ),
    );
  }
}
