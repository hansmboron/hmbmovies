import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/models/movie_model.dart';

abstract class MoviesRepository {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRated();
  Future<List<MovieModel>> getLatest();
  Future<MovieDetailsModel?> getDetail(int id);
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie);
  Future<List<MovieModel>> getFavoritiesMovies(String userId);
}
