import 'package:app_movies/models/movie_details_model.dart';
import 'package:flutter/material.dart';

class MovieDetailHeader extends StatelessWidget {
  const MovieDetailHeader({Key? key, required this.movie}) : super(key: key);

  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    if (movie != null) {
      return SizedBox(
        height: 278,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movie!.urlImages.length,
          itemBuilder: (context, index) {
            final image = movie!.urlImages[index];
            return Padding(
              padding: const EdgeInsets.all(2),
              child: Image.network(
                image,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 85,
                      width: 85,
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
