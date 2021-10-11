import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:app_movies/models/movie_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ContentTitle extends StatelessWidget {
  const ContentTitle({Key? key, required this.movie}) : super(key: key);

  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          movie?.title ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        RatingStars(
            value: (movie?.stars ?? 1),
            starColor: context.themeOrange,
            starSize: 14,
            maxValue: 10,
            maxValueVisibility: false,
            valueLabelColor: starsColor(movie?.stars ?? 1)),
        const SizedBox(height: 6),
        Text(
          movie?.genres.map((e) => e.name).join(', ') ?? '',
          style: TextStyle(fontSize: 11, color: context.themeGrey),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Color starsColor(double number) {
    if (number < 6) {
      return Colors.red;
    } else if (number < 8) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
