import 'package:app_movies/application/modules/module.dart';
import 'package:app_movies/modules/login/login_bindings.dart';
import 'package:app_movies/modules/login/login_page.dart';
import 'package:get/get.dart';

class LoginModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: LoginBindings(),
    )
  ];
}
