import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/models/movie_model.dart';

abstract class MoviesRepository {
  Future<List<MovieModel>> getPopularMovies(String page);
  Future<List<MovieModel>> getTopRated(String page);
  Future<List<MovieModel>> getLatest(String page);
  Future<List<MovieModel>> searchMovies(String name);
  Future<MovieDetailsModel?> getDetail(int id);
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie);
  Future<void> addTorrent(String movieId, String link, String youtube);
  Future<List<MovieModel>> getFavoritiesMovies(String userId);
}
