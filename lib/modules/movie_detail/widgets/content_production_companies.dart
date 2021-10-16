import 'package:app_movies/models/movie_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentProductionCompanies extends StatelessWidget {
  const ContentProductionCompanies({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 8),
      child: RichText(
        text: TextSpan(
            text: 'Companhia(s) produtora(s) : ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Color(0xFF222222),
            ),
            children: [
              TextSpan(
                text: movie?.productionCompanies.join(', ') ?? '',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              )
            ]),
      ),
    );
  }
}
