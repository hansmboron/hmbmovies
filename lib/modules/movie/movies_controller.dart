import 'package:app_movies/application/ui/messages/messages_mixin.dart';
import 'package:app_movies/models/genre_model.dart';
import 'package:app_movies/services/genres/genres_service.dart';
import 'package:get/get.dart';

class MovieController extends GetxController with MessagesMixin {
  final GenresService _genresService;
  final _message = Rxn<MessageModel>();
  final genres = <GenreModel>[].obs;

  MovieController({
    required GenresService genresService,
  }) : _genresService = genresService;

  @override
  void onInit() {
    messageListener(_message);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    try {
      final gen = await _genresService.getGenres();
      genres.assignAll(gen);
    } catch (e) {
      print('ERRO: ' + e.toString());
      _message(
        MessageModel.error(
            title: 'Erro!', message: 'Erro ao buscar categorias!!!'),
      );
    }
    super.onReady();
  }
}
