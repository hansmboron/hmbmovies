import 'package:app_movies/modules/favorite/favorites_controller.dart';
import 'package:get/get.dart';

class FavoritesBingings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      FavoritesController(
        authService: Get.find(),
        moviesService: Get.find(),
      ),
    );
  }
}
