import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544~3347511713";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2959116405567575/7975724296';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return " ca-app-pub-2959116405567575/7620501079";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static BannerAd loadSmallBanner(
      Function callbackOnLoaded, Function(Ad, LoadAdError) callBackOnFailed) {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          callbackOnLoaded();
        },
        onAdFailedToLoad: (ad, err) {
          callBackOnFailed(ad, err);
        },
      ),
    );
  }
}
