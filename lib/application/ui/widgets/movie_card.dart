import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:app_movies/models/movie_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final dateFormat = DateFormat('MM/y');
  final VoidCallback favoriteCallback;
  final VoidCallback? addToRec;
  final bool isAdmin;

  MovieCard({
    Key? key,
    required this.movie,
    required this.favoriteCallback,
    this.addToRec,
    this.isAdmin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/movie/detail', arguments: movie.id);
      },
      child: Container(
        height: 232,
        width: 124,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: context.themeRed,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                    height: 183,
                    width: 124,
                  ),
                ),
                const Spacer(),
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  dateFormat.format(
                      DateTime.tryParse(movie.releaseDate) ?? DateTime(0)),
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2)
              ],
            ),
            Positioned(
              bottom: 40,
              right: -6,
              child: Material(
                color: Colors.white.withAlpha(230),
                elevation: 3,
                clipBehavior: Clip.antiAlias,
                shape: const CircleBorder(),
                child: SizedBox(
                  height: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: favoriteCallback,
                    icon: Icon(
                      movie.favorite ? Icons.favorite : Icons.favorite_border,
                      color: movie.favorite ? context.themeRed : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            !isAdmin
                ? Container()
                : Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(color: Colors.red),
                    child: GestureDetector(
                      onTap: addToRec,
                      child: Icon(Icons.add),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
