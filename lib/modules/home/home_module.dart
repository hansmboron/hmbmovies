import 'package:app_movies/application/modules/module.dart';
import 'package:app_movies/modules/home/home_bindings.dart';
import 'package:app_movies/modules/home/home_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class HomeModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      binding: HomeBindings(),
    )
  ];
}
