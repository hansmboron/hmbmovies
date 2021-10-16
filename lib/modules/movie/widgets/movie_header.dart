import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:app_movies/modules/home/home_controller.dart';
import 'package:app_movies/modules/movie/movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MovieHeader extends GetView<MovieController> {
  MovieHeader({Key? key}) : super(key: key);

  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
      width: _size.width,
      height: _size.height * 0.25,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: _size.width,
            child: Image.asset(
              'assets/images/header2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
              width: _size.width * 0.9,
              padding: const EdgeInsets.only(bottom: 20),
              child: Obx(
                () => TextField(
                  controller: controller.searchCtrl,
                  textInputAction: TextInputAction.search,
                  // onChanged: (value) => controller.filterByName(value),
                  // onSubmitted: (value) async {
                  //   await controller.searchMovies(value.toString());
                  // },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: context.themeRed)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusColor: context.themeRed,
                    filled: true,
                    fillColor: _homeController.isDark.value
                        ? Colors.black54
                        : Colors.white,
                    labelText: 'Pesquisar Filmes',
                    labelStyle:
                        const TextStyle(fontSize: 15, color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 20),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: context.themeOrange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: context.themeRed,
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          await controller
                              .searchMovies(controller.searchCtrl.text);
                        },
                      ),
                    ),
                  ),
                ),
              )),
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: () {
                _homeController.isDark.toggle();
                if (_homeController.isDark.value) {
                  Get.changeTheme(
                    ThemeData.dark().copyWith(
                      primaryColor: context.themeRed,
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
                } else {
                  Get.changeTheme(
                    ThemeData.light().copyWith(
                      scaffoldBackgroundColor: Colors.white,
                      primaryColor: context.themeRed,
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.black,
                        ),
                        titleTextStyle: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: Obx(
                () => _homeController.isDark.value
                    ? Icon(
                        Icons.light_mode,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.nightlight,
                        color: Colors.white,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
