import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/models/movie_model.dart';
import 'package:app_movies/repositories/movies/movies_repository.dart';

import 'movies_service.dart';

class MoviesServiceImpl implements MoviesService {
  final MoviesRepository _moviesRepository;

  MoviesServiceImpl({required MoviesRepository moviesRepository})
      : _moviesRepository = moviesRepository;

  @override
  Future<List<MovieModel>> getPopularMovies(String page) =>
      _moviesRepository.getPopularMovies(page);
  @override
  Future<List<MovieModel>> getTopRated(String page) =>
      _moviesRepository.getTopRated(page);

  @override
  Future<List<MovieModel>> getLatest(String page) =>
      _moviesRepository.getLatest(page);

  @override
  Future<MovieDetailsModel?> getDetail(int id) =>
      _moviesRepository.getDetail(id);

  @override
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie) =>
      _moviesRepository.addOrRemoveFavorite(userId, movie);

  @override
  Future<List<MovieModel>> getFavoritiesMovies(String userId) =>
      _moviesRepository.getFavoritiesMovies(userId);
}
