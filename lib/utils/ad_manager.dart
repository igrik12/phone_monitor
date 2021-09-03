import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544~3347511713";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static Widget loadBanner(
      {AdmobAdEvent event,
      int width,
      int height = 80,
      void Function(AdmobAdEvent) eventCallback}) {
    return event == AdmobAdEvent.loaded
        ? Container(
            width: Get.width,
            child: CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AdmobBanner(
                  adUnitId: AdManager.bannerAdUnitId,
                  adSize: AdmobBannerSize.BANNER,
                  listener: (AdmobAdEvent event, Map<String, dynamic> args) {},
                ),
              ),
            ),
          )
        : SizedBox(
            height: 1,
            child: AdmobBanner(
              adUnitId: AdManager.bannerAdUnitId,
              adSize: AdmobBannerSize.BANNER,
              listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                if (event == AdmobAdEvent.loaded) {
                  eventCallback(AdmobAdEvent.loaded);
                }
                print(args);
                print("Event $event");
              },
            ),
          );
  }
}
