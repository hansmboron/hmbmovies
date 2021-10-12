import 'package:app_movies/application/ui/loader/loader_mixin.dart';
import 'package:app_movies/application/ui/messages/messages_mixin.dart';
import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/services/movies/movies_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsController extends GetxController
    with LoaderMixin, MessagesMixin {
  final MoviesService _moviesService;

  var loading = false.obs;
  var message = Rxn<MessageModel>();
  var movie = Rxn<MovieDetailsModel>();

  MovieDetailsController({
    required MoviesService moviesService,
  }) : _moviesService = moviesService;

  @override
  void onInit() {
    loaderListener(loading);
    messageListener(message);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    try {
      final movieId = Get.arguments;
      loading(true);
      final movieDetailData = await _moviesService.getDetail(movieId);
      movie.value = movieDetailData;
      // movie(movieDetailData);
      loading(false);
    } catch (e) {
      // print(e);
      // print(s);
      loading(false);
      message(MessageModel.error(
          title: 'Erro', message: 'Erro ao buscar detalhe do filme'));
    }
    super.onReady();
  }

  Future<void> launchURL(String url) async => await canLaunch(url)
      ? await launch(
          url,
          universalLinksOnly: false,
        )
      : message(
          MessageModel.error(title: 'Erro', message: 'Erro ao abrir link'));
}
