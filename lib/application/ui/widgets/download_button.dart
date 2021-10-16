import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/modules/movie_detail/movie_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DownloadButton extends GetView<MovieDetailsController> {
  const DownloadButton({Key? key, required this.movie}) : super(key: key);
  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        backgroundColor: movie?.download != ''
            ? MaterialStateProperty.all<Color>(context.themeRed)
            : MaterialStateProperty.all<Color>(Colors.grey.withAlpha(150)),
        shadowColor: MaterialStateProperty.all<Color>(context.themeGrey),
        overlayColor: MaterialStateProperty.all<Color>(context.themeOrange),
      ),
      onPressed: movie?.download == '' || movie?.download == null
          ? null
          : () {
              Get.defaultDialog(
                titleStyle: TextStyle(color: context.themeRed),
                title: 'Baixar Filme',
                onConfirm: () => controller.launchURL(movie?.download ?? ''),
                textConfirm: ' Baixar ',
                confirmTextColor: Colors.white,
                buttonColor: context.themeRed,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Para fazer o download do filme ',
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: movie?.title ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const TextSpan(
                              text:
                                  ' primeiro baixe um aplicativo de torrent, como por exemplo:')
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.launchURL(
                          'https://play.google.com/store/apps/details?id=com.utorrent.client&hl=pt_BR&gl=US'),
                      child: Text(
                        'UTorrent',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.launchURL(
                          'https://play.google.com/store/apps/details?id=com.delphicoder.flud&hl=pt_BR&gl=US'),
                      child: Text(
                        'Flud',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.launchURL(
                          'https://play.google.com/store/apps/details?id=com.bittorrent.client&hl=pt_BR&gl=US'),
                      child: Text(
                        'BitTorrent',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '* Todos os filmes são em DUAL audio ou em Português.',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      movie?.download ?? '',
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
              controller.showBigAd();
            },
      icon: const Icon(Icons.download_rounded),
      label: const Text('Download Torrent'),
    );
  }
}
