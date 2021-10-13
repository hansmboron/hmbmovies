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
                : () => Get.defaultDialog(
                      title: 'Baixar Filme',
                      onConfirm: () =>
                          controller.launchURL(movie?.download ?? ''),
                      textConfirm: 'Baixar',
                      confirmTextColor: Colors.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Para fazer o download do filme ',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: movie?.title ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const TextSpan(
                                      text:
                                          ' primeiro baixe um applicativo de torrent, como por exemplo: \nUTorrent\nFlud\nBitTorrent')
                                ]),
                          ),
                          const SizedBox(height: 16),
                          SelectableText(
                            movie?.download ?? '',
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
            icon: const Icon(Icons.download_rounded),
            label: const Text('Download Torrent'),
          ),
        ],
      ),
    );
  }
}
