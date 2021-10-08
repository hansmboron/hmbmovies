import 'package:app_movies/modules/movie/movies_controller.dart';
import 'package:app_movies/repositories/genres/genres_repository.dart';
import 'package:app_movies/repositories/genres/genres_repository_impl.dart';
import 'package:app_movies/services/genres/genres_service.dart';
import 'package:app_movies/services/genres/genres_service_impl.dart';
import 'package:get/get.dart';

class MoviesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenresRepository>(
      () => GenresRepositoryImpl(
        restClient: Get.find(),
      ),
    );
    Get.lazyPut<GenresService>(
        () => GenresServiceImpl(genresRepository: Get.find()));
    Get.lazyPut(() => MovieController(genresService: Get.find()));
  }
}
