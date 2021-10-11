// ignore_for_file: avoid_print

import 'package:app_movies/application/rest_client/rest_client.dart';
import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/models/movie_model.dart';
import 'package:app_movies/repositories/movies/movies_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      // 'page': '1'
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
      // 'page': '1'
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
  Future<MovieDetailsModel?> getDetail(int id) async {
    final result =
        await _restClient.get<MovieDetailsModel>('/movie/$id', query: {
      'api_key': RemoteConfig.instance.getString('api_token'),
      'language': 'pt-br',
      'append_to_response': 'images,credits',
      'include_image_language': 'en,pt-br'
    }, decoder: (data) {
      return MovieDetailsModel.fromMap(data);
    });

    if (result.hasError) {
      print(result.statusText);
      throw Exception('Erro ao buscar detalhes do filme!');
    }
    return result.body;
  }

  @override
  Future<List<MovieModel>> getLatest() async {
    final result =
        await _restClient.get<List<MovieModel>>('/movie/upcoming', query: {
      'api_key': RemoteConfig.instance.getString('api_token'),
      'language': 'pt-br',
      // 'page': '1'
    }, decoder: (data) {
      final results = data['results'];
      if (results != null) {
        return results.map<MovieModel>((m) => MovieModel.fromMap(m)).toList();
      }
      return <MovieModel>[];
    });

    if (result.hasError) {
      print(result.statusText);
      throw Exception('Erro ao buscar filmes lançamentos!');
    }
    return result.body ?? <MovieModel>[];
  }

  @override
  Future<void> addOrRemoveFavorite(String userId, MovieModel movie) async {
    try {
      var favoriteCollection = FirebaseFirestore.instance
          .collection('fav')
          .doc(userId)
          .collection('movies');

      if (movie.favorite) {
        favoriteCollection.add(movie.toMap());
      } else {
        var favoriteData = await favoriteCollection
            .where('id', isEqualTo: movie.id)
            .limit(1)
            .get();
        favoriteData.docs.first.reference.delete();
      }
    } catch (e) {
      print(e);
      print('Erro ao favoritar um filme');
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getFavoritiesMovies(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> favMovies = await FirebaseFirestore
          .instance
          .collection('fav')
          .doc(userId)
          .collection('movies')
          .orderBy('title')
          .get();

      final listFavorites = <MovieModel>[];
      for (var movie in favMovies.docs) {
        listFavorites.add(MovieModel.fromMap(movie.data()));
      }
      return listFavorites;
    } catch (e) {
      print('ERRO:' + e.toString());
      return <MovieModel>[];
    }
  }
}
