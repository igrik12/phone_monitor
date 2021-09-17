import 'package:battery_info/enums/charging_status.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/tabs/dashboard/battery_card.dart';
import 'package:phone_monitor/tabs/dashboard/overview.dart';
import 'package:phone_monitor/widgets/animated_text.dart';
import 'package:phone_monitor/widgets/progress_wave.dart';

import 'sensor_counter.dart';
import 'app_counter.dart';
import 'display_card.dart';
import 'storage_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: FacebookNativeAd(
                  placementId:
                      "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
                  adType: NativeAdType.NATIVE_BANNER_AD,
                  bannerAdSize: NativeBannerAdSize.HEIGHT_50,
                  width: double.infinity,
                  backgroundColor: Theme.of(context).primaryColor,
                  titleColor: Colors.white,
                  descriptionColor: Colors.white,
                  buttonColor: Colors.deepPurple,
                  buttonTitleColor: Colors.white,
                  buttonBorderColor: Colors.white,
                  listener: (result, value) {
                    print("Native Banner Ad: $result --> $value");
                  },
                ),
              ),
              const DashboardOverview(),
              const StorageCard(),
              const BatteryCard(),
              const DisplayCard(),
              Row(
                children: const [
                  SensorCounter(),
                  Expanded(child: AppCounter())
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
