import 'package:app_movies/application/ui/loader/loader_mixin.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoaderMixin {
  final loading = false.obs;

  @override
  void onInit() {
    loaderListener(loading);
    super.onInit();
  }

  Future<void> login() async {
    loading(true); //callable class
    await Future.delayed(const Duration(seconds: 6));
    loading.value = false;
  }
}
