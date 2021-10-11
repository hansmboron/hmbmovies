import 'package:app_movies/application/ui/theme_extensions.dart';
import 'package:app_movies/models/cast_model.dart';
import 'package:flutter/material.dart';

class MovieCast extends StatelessWidget {
  const MovieCast({Key? key, required this.cast}) : super(key: key);
  final CastModel? cast;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              cast?.image ??
                  'https://hansmboron.free.resourcespace.com/filestore/hansmboron/1/1/1/4_b15a19c9301d26e/1114scr_26cec469bfb05d6.jpg?v=1621270273',
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
              height: 85,
              width: 85,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            cast?.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            cast?.character ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: context.themeGrey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
