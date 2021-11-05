import 'package:app_movies/application/auth/auth_service.dart';
import 'package:app_movies/services/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final String key = 'theme';
  RxBool isDark = Get.isDarkMode.obs;
  SharedPreferences? _prefs;

  int get pageIndex => _pageIndex.value;

  @override
  void onInit() {
    _loadFromPrefs();
    super.onInit();
  }

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

  Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();
    isDark.value = _prefs!.getBool(key) ?? false;
    if (isDark.value) {
      Get.changeTheme(
        ThemeData.dark().copyWith(
          primaryColor: Color(0xffea4335),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  Future<void> saveToPrefs() async {
    await _initPrefs();
    _prefs!.setBool(key, isDark.value);
  }
}
