import 'package:app_movies/application/auth/auth_service.dart';
import 'package:app_movies/application/ui/messages/messages_mixin.dart';
import 'package:app_movies/models/movie_model.dart';
import 'package:app_movies/services/movies/movies_service.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController with MessagesMixin {
  final MoviesService _moviesService;
  final AuthService _authService;

  final _message = Rxn<MessageModel>();
  RxList movies = <MovieModel>[].obs;
  RxBool get isLogedIn => (_authService.user != null).obs;

  FavoritesController(
      {required MoviesService moviesService, required AuthService authService})
      : _moviesService = moviesService,
        _authService = authService;

  @override
  void onInit() {
    messageListener(_message);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await _getFavorites();
    super.onReady();
  }

  Future<void> _getFavorites() async {
    var user = _authService.user;
    if (user != null) {
      var favorites = await _moviesService.getFavoritiesMovies(user.uid);
      movies.assignAll(favorites);
    }
  }

  Future<void> removeFavorite(MovieModel movie) async {
    var user = _authService.user;
    if (user != null) {
      await _moviesService.addOrRemoveFavorite(
        user.uid,
        movie.copyWith(favorite: false),
      );
      movies.remove(movie);
      _message(MessageModel.error(
          title: 'Removido dos favoritos com sucesso!', message: movie.title));
    }
  }
}
