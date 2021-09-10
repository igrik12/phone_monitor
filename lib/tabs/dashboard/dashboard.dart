import 'package:battery_info/enums/charging_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/tabs/dashboard/battery_card.dart';
import 'package:phone_monitor/tabs/dashboard/overview.dart';
import 'package:phone_monitor/utils/ad_manager.dart';
import 'package:phone_monitor/widgets/animated_text.dart';
import 'package:phone_monitor/widgets/progress_wave.dart';

import 'sensor_counter.dart';
import 'app_counter.dart';
import 'display_card.dart';
import 'storage_card.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  @override
  void initState() {
    super.initState();
    _bannerAd = AdManager.loadSmallBanner(() {
      setState(() {
        _isBannerAdReady = true;
      });
    }, (ad, err) {
      print('Failed to load a banner ad: ${err.message}');
      _isBannerAdReady = false;
      ad.dispose();
    });
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              if (_isBannerAdReady)
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
              DashboardOverview(),
              StorageCard(),
              const BatteryCard(),
              const DisplayCard(),
              Row(
                children: const [
                  SensorCounter(),
                  Expanded(
                    child: AppCounter(),
                  )
                ],
              )
            ],
          ),
        ),
        Obx(() => DashboardController.to.wrapper.value.battery.chargingStatus ==
                ChargingStatus.Charging
            ? Align(
                alignment: Alignment.bottomCenter,
                child: WaveBall(
                  circleColor: Colors.transparent,
                  size: 85,
                  foregroundColor: Get.theme.primaryColor,
                  backgroundColor: Get.theme.primaryColor,
                  progress: DashboardController
                          .to.wrapper.value.battery.batteryLevel /
                      100,
                  child: Center(
                    child: buildChargeState(),
                  ),
                ),
              )
            : const SizedBox.shrink())
      ]),
    );
  }

  Widget buildChargeState() {
    final chargeTime =
        DashboardController.to.wrapper.value.battery.chargeTimeRemaining;
    if (chargeTime == -1) {
      return const AnimatedTextWidget(
        staticText: '',
        animatedText: '....',
      );
    }
    return Text(
      '~${(chargeTime / 1000 / 60).truncate()} mins',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.blue : Colors.amber),
    );
  }
}
