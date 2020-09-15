import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/tabs/dashboard/battery_card.dart';
import 'package:phone_monitor/tabs/dashboard/overview.dart';

import 'SensorCounter.dart';
import 'appCounter.dart';
import 'display_card.dart';
import 'storage_card.dart';

class Dashboard extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DashboardOverview(),
            // DismissableAdBanner(), DISABLED TILL THE APP KICKS OFF
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
    );
  }
}
