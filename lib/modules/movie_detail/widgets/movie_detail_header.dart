import 'package:app_movies/models/movie_details_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            final image = movie?.urlImages[index] ??
                'https://hansmboron.free.resourcespace.com/filestore/hansmboron/1/1/1/4_b15a19c9301d26e/1114scr_26cec469bfb05d6.jpg?v=1621270273';
            return Padding(
              padding: const EdgeInsets.all(2),
              child: CachedNetworkImage(
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
