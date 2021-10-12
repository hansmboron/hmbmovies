import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/modules/movie_detail/movie_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentCredits extends GetView<MovieDetailsController> {
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
          ElevatedButton.icon(
            onPressed: movie?.download == '' || movie?.download == null
                ? null
                : () => controller.launchURL(movie?.download ?? ''),
            icon: const Icon(Icons.download_rounded),
            label: const Text('Download Torrent'),
          )
        ],
      ),
    );
  }
}
