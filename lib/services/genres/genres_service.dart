import 'package:app_movies/models/genre_model.dart';
import 'package:app_movies/repositories/genres/genres_repository.dart';

abstract class GenresService {
  Future<List<GenreModel>> getGenres();
}
