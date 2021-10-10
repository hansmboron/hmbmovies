import 'dart:convert';

import 'package:app_movies/models/cast_model.dart';
import 'package:app_movies/models/genre_model.dart';

class MovieDetailsModel {
  final String title;
  final double stars;
  final List<GenreModel> genres;
  final List<String> urlImages;
  final DateTime releaseDate;
  final String overview;
  final List<String> productionCompanies;
  final String originalLanguage;
  final List<CastModel> cast;

  MovieDetailsModel({
    required this.title,
    required this.stars,
    required this.genres,
    required this.urlImages,
    required this.releaseDate,
    required this.overview,
    required this.productionCompanies,
    required this.originalLanguage,
    required this.cast,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'vote_average': stars,
      'genres': genres.map((x) => x.toMap()).toList(),
      'url_images': urlImages,
      'release_date': releaseDate.millisecondsSinceEpoch,
      'overview': overview,
      'production_companies': productionCompanies,
      'original_language': originalLanguage,
      'cast': cast.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    var urlImagesPosters = map['images']['posters'];
    var urlImages = urlImagesPosters
            ?.map<String>(
                (i) => 'https://image.tmdb.org/t/p/w200${i['file_path']}')
            .toList() ??
        const [];

    return MovieDetailsModel(
      title: map['title'],
      stars: map['vote_average'],
      genres: List<GenreModel>.from(
          map['genres']?.map((x) => GenreModel.fromMap(x))),
      urlImages: urlImages,
      releaseDate: DateTime.parse(map['release_date']),
      overview: map['overview'],
      productionCompanies:
          List<dynamic>.from(map['production_companies'] ?? const [])
              .map<String>((p) => p['name'])
              .toList(),
      originalLanguage: map['original_language'],
      cast: List<CastModel>.from(
          map['credits']['cast']?.map((x) => CastModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailsModel.fromJson(String source) =>
      MovieDetailsModel.fromMap(json.decode(source));
}
