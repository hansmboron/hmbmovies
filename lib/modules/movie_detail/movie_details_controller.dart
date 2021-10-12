import 'package:app_movies/application/auth/auth_service.dart';
import 'package:app_movies/application/ui/loader/loader_mixin.dart';
import 'package:app_movies/application/ui/messages/messages_mixin.dart';
import 'package:app_movies/models/movie_details_model.dart';
import 'package:app_movies/services/movies/movies_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsController extends GetxController
    with LoaderMixin, MessagesMixin {
  final MoviesService _moviesService;
  final AuthService _authService;

  var loading = false.obs;
  var message = Rxn<MessageModel>();
  var movie = Rxn<MovieDetailsModel>();

  var isAdmin = false.obs;

  MovieDetailsController({
    required MoviesService moviesService,
    required AuthService authService,
  })  : _moviesService = moviesService,
        _authService = authService;

  @override
  void onInit() {
    loaderListener(loading);
    messageListener(message);
    String admin = RemoteConfig.instance.getString('hans_pro');
    if (admin == _authService.user?.uid) {
      isAdmin.value = true;
    } else {
      isAdmin.value = false;
    }
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
