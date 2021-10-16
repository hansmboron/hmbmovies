import 'package:app_movies/application/auth/auth_service.dart';
import 'package:app_movies/application/ui/loader/loader_mixin.dart';
import 'package:app_movies/application/ui/messages/messages_mixin.dart';
import 'package:app_movies/models/genre_model.dart';
import 'package:app_movies/models/movie_model.dart';
import 'package:app_movies/services/genres/genres_service.dart';
import 'package:app_movies/services/movies/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieController extends GetxController with MessagesMixin, LoaderMixin {
  // final GenresService _genresService;
  final MoviesService _moviesService;
  final AuthService _authService;

  final _message = Rxn<MessageModel>();
  final loading = false.obs;
  final genres = <GenreModel>[].obs;
  final popularMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;
  final latestMovies = <MovieModel>[].obs;
  final queryList = <MovieModel>[].obs;
  final genreSelected = Rxn<GenreModel>();

  final TextEditingController searchCtrl = TextEditingController();

  RxBool get hasResult => (queryList.length > 0).obs;
  RxBool get isLogedIn => (_authService.user != null).obs;
  var _page1 = 1.obs;
  var _page2 = 1.obs;
  var _page3 = 1.obs;

  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];
  var _latestMoviesOriginal = <MovieModel>[];

  MovieController({
    required GenresService genresService,
    required MoviesService moviesService,
    required AuthService authService,
  })  : _moviesService = moviesService,
        _authService = authService;

  @override
  void onInit() {
    loaderListener(loading);
    messageListener(_message);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    try {
      // final genData = await _genresService.getGenres();
      // genres.assignAll(genData);
      await getMovies();
    } catch (e) {
      // ignore: avoid_print
      print('ERRO: ' + e.toString());
      _message(
        MessageModel.error(
            title: 'Erro!', message: 'Erro ao carregar dados da página!!!'),
      );
    }
    super.onReady();
  }

  Future<void> getMovies() async {
    _page1.value = 1;
    _page2.value = 1;
    _page3.value = 1;
    var popularMoviesData = await _moviesService.getPopularMovies('1');
    var topRatedMoviesData = await _moviesService.getTopRated('1');
    var latestMoviesData = await _moviesService.getLatest('1');
    if (isLogedIn.value) {
      final favorites = await getFavorites();

      popularMoviesData = popularMoviesData.map((m) {
        if (favorites.containsKey(m.id)) {
          return m.copyWith(favorite: true);
        } else {
          return m.copyWith(favorite: false);
        }
      }).toList();

      topRatedMoviesData = topRatedMoviesData.map((m) {
        if (favorites.containsKey(m.id)) {
          return m.copyWith(favorite: true);
        } else {
          return m.copyWith(favorite: false);
        }
      }).toList();

      latestMoviesData = latestMoviesData.map((m) {
        if (favorites.containsKey(m.id)) {
          return m.copyWith(favorite: true);
        } else {
          return m.copyWith(favorite: false);
        }
      }).toList();
    }

    popularMovies.assignAll(popularMoviesData);
    _popularMoviesOriginal = popularMoviesData;
    topRatedMovies.assignAll(topRatedMoviesData);
    _topRatedMoviesOriginal = topRatedMoviesData;
    latestMovies.assignAll(latestMoviesData);
    _latestMoviesOriginal = latestMoviesData;
  }

  void filterByName(String title) {
    if (title.isNotEmpty) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });
      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });
      var newLatestMovies = _latestMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
      latestMovies.assignAll(newLatestMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
      latestMovies.assignAll(_latestMoviesOriginal);
    }
  }

  Future<void> searchMovies(String name) async {
    try {
      if (name != null || name != '') {
        loading.value = true;
        List<MovieModel> _newResultList =
            await _moviesService.searchMovies(name);

        queryList.clear();
        // queryList.assignAll(_newResultList);
        for (var item in _newResultList) {
          queryList.add(item);
        }

        loading.value = false;

        if (queryList.isEmpty) {
          _message(MessageModel.error(
              title: 'Nada encontrado!', message: 'Tente digitar outra coisa'));
        }
      } else {
        _message(MessageModel.error(title: 'Erro!', message: 'Nada digitado'));
      }
    } catch (e, s) {
      loading.value = false;
      print(e);
      print(s);
      _message(MessageModel.error(
          title: 'Erro!', message: '${e.toString()} | ${s.toString()}'));
    }
  }

  void filterMoviesByGenre(GenreModel? genreModel) {
    var genreFilter = genreModel;

    if (genreFilter?.id == genreSelected.value?.id) {
      genreFilter = null;
    }

    genreSelected.value = genreFilter;

    if (genreFilter != null) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.genres.contains(genreFilter?.id);
      });
      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.genres.contains(genreFilter?.id);
      });
      var newLatestMovies = _latestMoviesOriginal.where((movie) {
        return movie.genres.contains(genreFilter?.id);
      });

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
      latestMovies.assignAll(newLatestMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
      latestMovies.assignAll(_latestMoviesOriginal);
    }
  }

  Future<void> favoriteMovie(MovieModel movie) async {
    final user = _authService.user;
    if (user != null) {
      var newMovie = movie.copyWith(favorite: !movie.favorite);
      await _moviesService.addOrRemoveFavorite(user.uid, newMovie);
      // await getMovies();
      _message(MessageModel.info(
          title: 'Adicionado ou Removido dos favoritos com sucesso!',
          message: movie.title));
    } else {
      _message(MessageModel.error(
          title: 'Usuário não logado!',
          message:
              'Faça login para poder adicionar o filme ${movie.title} aos favoritos!'));
    }
  }

  Future<Map<int, MovieModel>> getFavorites() async {
    var user = _authService.user;
    if (user != null) {
      final favorites = await _moviesService.getFavoritiesMovies(user.uid);
      return <int, MovieModel>{
        for (var fav in favorites) fav.id: fav,
      };
    } else {
      return {};
    }
  }

  String nextPage1() {
    var page = _page1++;
    return page.toString();
  }

  String nextPage2() {
    var page = _page2++;
    return page.toString();
  }

  String nextPage3() {
    var page = _page3++;
    return page.toString();
  }

  Future<void> getNextLatest() async {
    var latestMoviesData = await _moviesService.getLatest(nextPage1());
    final favorites = await getFavorites();

    latestMoviesData = latestMoviesData.map((m) {
      if (favorites.containsKey(m.id)) {
        return m.copyWith(favorite: true);
      } else {
        return m.copyWith(favorite: false);
      }
    }).toList();

    latestMovies.addAll(latestMoviesData);
    _latestMoviesOriginal = latestMoviesData;
  }

  Future<void> getNextPop() async {
    var popularMoviesData = await _moviesService.getPopularMovies(nextPage2());
    final favorites = await getFavorites();

    popularMoviesData = popularMoviesData.map((m) {
      if (favorites.containsKey(m.id)) {
        return m.copyWith(favorite: true);
      } else {
        return m.copyWith(favorite: false);
      }
    }).toList();

    popularMovies.addAll(popularMoviesData);
    _latestMoviesOriginal = popularMoviesData;
  }

  Future<void> getNextTop() async {
    var topMoviesData = await _moviesService.getTopRated(nextPage3());
    final favorites = await getFavorites();

    topMoviesData = topMoviesData.map((m) {
      if (favorites.containsKey(m.id)) {
        return m.copyWith(favorite: true);
      } else {
        return m.copyWith(favorite: false);
      }
    }).toList();

    topRatedMovies.addAll(topMoviesData);
    _latestMoviesOriginal = topMoviesData;
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 20 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 20;

    if (requestMoreData && pageToRequest + 1 >= _page1.value) {
      getNextLatest();
      getNextTop();
      getNextPop();
      print('OBTEVE');
    }
  }
}
