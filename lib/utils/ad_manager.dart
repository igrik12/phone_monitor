import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8553583576390987~6421066446";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8553583576390987/4063508172";
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
