import 'package:app_movies/application/ui/widgets/ad_container.dart';
import 'package:app_movies/modules/movie/movies_controller.dart';
import 'package:app_movies/modules/movie/widgets/movie_header.dart';
import 'package:app_movies/modules/movie/widgets/movies_group.dart';
import 'package:app_movies/services/admob/admob_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesPage extends GetView<MovieController> {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _orientation = MediaQuery.of(context).orientation.index;
    return Scaffold(
      body: ListView(
        children: [
          MovieHeader(),
          // const MoviesFilters(),

          Obx(
            () => controller.hasResult.value
                ? MoviesGroup(
                    title: 'Resultados:  ${controller.queryList.length}',
                    movies: controller.queryList,
                    onPressed: () {
                      controller.queryList.clear();
                      controller.searchCtrl.text = '';
                    },
                  )
                : Container(),
          ),
          MoviesGroup(
            title: 'Recomendados',
            movies: controller.recomendedList,
          ),
          MoviesGroup(
            title: 'Últimos lançamentos',
            movies: controller.latestMovies,
          ),
          MoviesGroup(
            title: 'Mais Populares',
            movies: controller.popularMovies,
          ),
          MoviesGroup(
            title: 'Top filmes',
            movies: controller.topRatedMovies,
          ),
          // AdContainner(
          //   height: 301,
          //   ad: AdMobService.createRectangleBannerAd()..load(),
          // ),
        ],
      ),
      bottomNavigationBar: _orientation == 1
          ? null
          : AdContainner(
              height: 60,
              ad: AdMobService.createBannerAd()..load(),
            ),
    );
  }
}
