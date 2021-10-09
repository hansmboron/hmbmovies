import 'package:app_movies/application/rest_client/rest_client.dart';
import 'package:app_movies/models/movie_model.dart';
import 'package:app_movies/repositories/movies/movies_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final RestClient _restClient;

  MoviesRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final result =
        await _restClient.get<List<MovieModel>>('/movie/popular', query: {
      'api_key': RemoteConfig.instance.getString('api_token'),
      'language': 'pt-br',
      'page': '1'
    }, decoder: (data) {
      final results = data['results'];
      if (results != null) {
        return results.map<MovieModel>((m) => MovieModel.fromMap(m)).toList();
      }
      return <MovieModel>[];
    });

    if (result.hasError) {
      print(result.statusText);
      throw Exception('Erro ao buscar filmes populares!');
    }
    return result.body ?? <MovieModel>[];
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    final result =
        await _restClient.get<List<MovieModel>>('/movie/top_rated', query: {
      'api_key': RemoteConfig.instance.getString('api_token'),
      'language': 'pt-br',
      'page': '1'
    }, decoder: (data) {
      final results = data['results'];
      if (results != null) {
        return results.map<MovieModel>((m) => MovieModel.fromMap(m)).toList();
      }
      return <MovieModel>[];
    });

    if (result.hasError) {
      print(result.statusText);
      throw Exception('Erro ao buscar filmes populares!');
    }
    return result.body ?? <MovieModel>[];
  }
}
