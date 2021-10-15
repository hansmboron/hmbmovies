import 'package:app_movies/application/ui/loader/loader_mixin.dart';
import 'package:app_movies/application/ui/messages/messages_mixin.dart';
import 'package:app_movies/services/login/login_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final LoginService _loginService;
  final loading = false.obs;
  final message = Rxn<MessageModel>();

  LoginController({required LoginService loginService})
      : _loginService = loginService;

  @override
  void onInit() {
    loaderListener(loading);
    messageListener(message);
    super.onInit();
  }

  Future<void> login() async {
    try {
      loading(true); //callable class
      await _loginService.login();
      loading(false);
      message(
        MessageModel.info(
            title: 'Login Sucesso!', message: 'Login Realizado com sucesso!!!'),
      );
    } catch (e, s) {
      loading(false);
      print(e);
      print(s);
      message(
        MessageModel.error(title: 'Login Erro!', message: e.toString()),
      );
    }

    // await 2.seconds.delay();
  }
}
