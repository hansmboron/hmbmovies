import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/models/movie_model.dart';

abstract class MoviesService {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRated();
  Future<MovieDetailsModel?> getDetail(int id);
}
