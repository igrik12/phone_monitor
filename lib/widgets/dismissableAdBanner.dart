import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/utils/ad_manager.dart';

import 'custom_card.dart';

class DismissableAdBanner extends StatelessWidget {
  const DismissableAdBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: SizedBox(
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
      ),
    );
  }
}
