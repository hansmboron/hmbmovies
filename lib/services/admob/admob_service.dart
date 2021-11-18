import 'dart:io' show Platform;

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String get bannerAdUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : '';
  static String get interstitialAdUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : ''; //test
  // static String get bannerAdUnitId =>
  //     Platform.isAndroid ? 'ca-app-pub-8811308148602440/4889391339' : '';
  // static String get interstitialAdUnitId =>
  //     Platform.isAndroid ? 'ca-app-pub-8811308148602440/9950146327' : ''; //hans

  static BannerAd createBannerAd() {
    BannerAd ad = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('AD LOADED!'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('AD OPENED'),
        onAdClosed: (Ad ad) => print('AD CLOSED'),
      ),
      request: AdRequest(),
    );

    return ad;
  }

  static BannerAd createRectangleBannerAd() {
    BannerAd ad = BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('AD LOADED!'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('AD OPENED'),
        onAdClosed: (Ad ad) => print('AD CLOSED'),
      ),
      request: AdRequest(),
    );

    return ad;
  }

  InterstitialAd? _intertitialAd;
  int numAtemptLoad = 0;

  void createIntertitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        _intertitialAd = ad;
        numAtemptLoad = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        numAtemptLoad += 1;
        _intertitialAd = null;
        if (numAtemptLoad <= 2) {
          createIntertitialAd();
        }
      }),
    );
  }

  void showInterAd() {
    if (_intertitialAd == null) {
      return;
    }
    _intertitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad ONADFAILED $error');
      ad.dispose();
      createIntertitialAd();
    });
    _intertitialAd!.show();
    _intertitialAd = null;
  }
}
