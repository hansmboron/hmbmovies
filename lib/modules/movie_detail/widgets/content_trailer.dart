import 'package:app_movies/models/movie_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../movie_details_controller.dart';

class ContentTrailer extends GetView<MovieDetailsController> {
  const ContentTrailer({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const Text(
          'Trailer',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId:
                YoutubePlayer.convertUrlToId(movie?.youtube ?? '') ??
                    'Q4GzdZ1ODAg',
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              captionLanguage: 'pt',
              enableCaption: true,
            ),
          ),
        ),
        SizedBox(height: 4),
        GestureDetector(
          onTap: () => controller.launchURL(movie?.youtube ?? ''),
          child: Text.rich(
            TextSpan(text: 'Link: ', children: [
              TextSpan(
                text: movie?.youtube ?? '',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        )
      ],
    );
  }
}
