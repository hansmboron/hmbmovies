import 'package:app_movies/application/auth/auth_service.dart';
import 'package:app_movies/application/ui/messages/messages_mixin.dart';
import 'package:app_movies/models/genre_model.dart';
import 'package:app_movies/models/movie_model.dart';
import 'package:app_movies/services/genres/genres_service.dart';
import 'package:app_movies/services/movies/movies_service.dart';
import 'package:get/get.dart';

class MovieController extends GetxController with MessagesMixin {
  final GenresService _genresService;
  final MoviesService _moviesService;
  final AuthService _authService;

  final _message = Rxn<MessageModel>();
  final genres = <GenreModel>[].obs;
  final popularMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;
  final latestMovies = <MovieModel>[].obs;
  final genreSelected = Rxn<GenreModel>();

  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];
  var _latestMoviesOriginal = <MovieModel>[];

  MovieController({
    required GenresService genresService,
    required MoviesService moviesService,
    required AuthService authService,
  })  : _genresService = genresService,
        _moviesService = moviesService,
        _authService = authService;

  @override
  void onInit() {
    messageListener(_message);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    try {
      final genData = await _genresService.getGenres();
      genres.assignAll(genData);

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
    var popularMoviesData = await _moviesService.getPopularMovies();
    var topRatedMoviesData = await _moviesService.getTopRated();
    var latestMoviesData = await _moviesService.getLatest();
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
      await getMovies();
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
}
