import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:app_movies/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/bg.jpg',
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black54,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.17),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: Get.width * 0.4,
                  width: Get.width * 0.4,
                ),
              ),
              InkWell(
                onTap: () => controller.login(),
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  clipBehavior: Clip.antiAlias,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 50,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Entrar com o Google',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(context.themeOrange),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white70),
                ),
                onPressed: () => Get.toNamed('/home'),
                child: Text(
                  'Entrar sem login',
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
