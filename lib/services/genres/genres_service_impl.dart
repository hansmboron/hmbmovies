import 'package:app_movies/models/genre_model.dart';
import 'package:app_movies/repositories/genres/genres_repository.dart';
import 'package:app_movies/services/genres/genres_service.dart';

class GenresServiceImpl extends GenresService {
  final GenresRepository _genresRepository;

  GenresServiceImpl({
    required GenresRepository genresRepository,
  }) : _genresRepository = genresRepository;

  @override
  Future<List<GenreModel>> getGenres() => _genresRepository.getGenres();
}
