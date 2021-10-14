import 'package:app_movies/application/ui/widgets/download_button.dart';
import 'package:app_movies/models/movie_details_model.dart';
import 'package:flutter/material.dart';

class ContentCredits extends StatelessWidget {
  const ContentCredits({Key? key, required this.movie}) : super(key: key);
  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50),
      child: Column(
        children: [
          Text(
            movie?.overview ?? '',
            style: const TextStyle(height: 1.3),
          ),
          DownloadButton(
            movie: movie,
          )
        ],
      ),
    );
  }
}
