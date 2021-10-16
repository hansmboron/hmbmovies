import 'package:app_movies/application/auth/auth_service.dart';
import 'package:app_movies/services/login/login_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool get isLogedIn => (_authService.user != null).obs;
  static const navigatorKey = 1;
  static const indexExit = 2;

  final LoginService _loginService;
  final AuthService _authService;
  HomeController({
    required LoginService loginService,
    required AuthService authService,
  })  : _loginService = loginService,
        _authService = authService;

  final _pages = ['/movies', '/favorites'];
  final _pageIndex = 0.obs;
  RxBool isDark = Get.isDarkMode.obs;

  int get pageIndex => _pageIndex.value;

  void goToPage(int page) {
    _pageIndex(page);
    if (page == indexExit) {
      if (isLogedIn.value) {
        _loginService.logout();
      } else {
        Get.offAllNamed('/login');
      }
    } else {
      Get.offNamed(_pages[page], id: navigatorKey);
    }
  }
}
