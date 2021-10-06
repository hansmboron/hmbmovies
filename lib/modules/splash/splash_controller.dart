import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Get.offAllNamed('/login');
    super.onReady();
  }
}
