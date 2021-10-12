import 'package:app_movies/modules/movie_detail/movie_details_controller.dart';
import 'package:get/get.dart';

class MovieDetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MovieDetailsController(
      moviesService: Get.find(),
      authService: Get.find(),
    ));
  }
}
