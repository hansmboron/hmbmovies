import 'package:app_movies/services/login/login_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static const navigatorKey = 1;
  static const indexExit = 2;

  final LoginService _loginService;
  HomeController({
    required LoginService loginService,
  }) : _loginService = loginService;

  final _pages = ['/movies', '/favorites'];
  final _pageIndex = 0.obs;

  int get pageIndex => _pageIndex.value;

  void goToPage(int page) {
    _pageIndex(page);
    if (page == indexExit) {
      _loginService.logout();
    } else {
      Get.offNamed(_pages[page], id: navigatorKey);
    }
  }
}
