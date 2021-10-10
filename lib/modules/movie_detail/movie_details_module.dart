import 'package:app_movies/application/modules/module.dart';
import 'package:app_movies/modules/movie_detail/movie_details_bindings.dart';
import 'package:app_movies/modules/movie_detail/movie_details_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class MovieDetailsModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/movie/detail',
      page: () => MovieDetailsPage(),
      binding: MovieDetailsBindings(),
    )
  ];
}
