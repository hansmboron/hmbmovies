import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:app_movies/modules/favorite/favorites_bindings.dart';
import 'package:app_movies/modules/favorite/favorites_page.dart';
import 'package:app_movies/modules/home/home_controller.dart';
import 'package:app_movies/modules/movie/movies_bindings.dart';
import 'package:app_movies/modules/movie/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
          key: Get.nestedKey(HomeController.navigatorKey),
          initialRoute: '/movies',
          onGenerateRoute: (settings) {
            if (settings.name == '/movies') {
              return GetPageRoute(
                settings: settings,
                page: () => const MoviesPage(),
                binding: MoviesBindings(),
              );
            }
            if (settings.name == '/favorites') {
              return GetPageRoute(
                settings: settings,
                page: () => const FavoritesPage(),
                binding: FavoritesBingings(),
              );
            }

            return null;
          },
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            selectedItemColor: context.themeRed,
            unselectedItemColor: Colors.grey,
            onTap: controller.goToPage,
            currentIndex: controller.pageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Filmes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favoritos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Sair',
              ),
            ],
          ),
        ));
  }
}
