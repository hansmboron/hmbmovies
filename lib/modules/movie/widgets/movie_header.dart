import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:app_movies/modules/movie/movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieHeader extends GetView<MovieController> {
  const MovieHeader({Key? key}) : super(key: key);

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
            child: TextField(
              controller: controller.searchCtrl,
              textInputAction: TextInputAction.search,
              // onChanged: (value) => controller.filterByName(value),
              // onSubmitted: (value) async {
              //   await controller.searchMovies(value.toString());
              // },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Pesquisar Filmes',
                labelStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 20),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    color: context.themeOrange,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      await controller.searchMovies(controller.searchCtrl.text);
                      print('TEXTO ENVIADO: ${controller.searchCtrl.text}');
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
