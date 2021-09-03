import 'package:battery_info/enums/charging_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/tabs/dashboard/battery_card.dart';
import 'package:phone_monitor/tabs/dashboard/overview.dart';
import 'package:phone_monitor/widgets/animatedText.dart';
import 'package:phone_monitor/widgets/progressWave.dart';

import 'SensorCounter.dart';
import 'appCounter.dart';
import 'display_card.dart';
import 'storage_card.dart';

class Dashboard extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              DashboardOverview(),
              StorageCard(),
              BatteryCard(),
              DisplayCard(),
              Row(
                children: [
                  SensorCounter(),
                  Expanded(
                    child: AppCounter(),
                  )
                ],
              )
            ],
          ),
        ),
        Obx(() => controller.wrapper.value.battery.chargingStatus ==
                ChargingStatus.Charging
            ? Align(
                alignment: Alignment.bottomCenter,
                child: WaveBall(
                  circleColor: Colors.transparent,
                  size: 85,
                  foregroundColor: Get.theme.accentColor,
                  backgroundColor: Get.theme.primaryColor,
                  progress: controller.wrapper.value.battery.batteryLevel / 100,
                  child: Center(
                    child: buildChargeState(),
                  ),
                ),
              )
            : SizedBox.shrink())
      ]),
    );
  }

  Widget buildChargeState() {
    final chargeTime = controller.wrapper.value.battery.chargeTimeRemaining;
    if (chargeTime == -1) {
      return AnimatedTextWidget(
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
