import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/controllers/homeController.dart';
import 'package:phone_monitor/tabs/applications/applications.dart';
import 'package:phone_monitor/tabs/dashboard/battery_card.dart';
import 'package:phone_monitor/tabs/dashboard/overview.dart';
import 'package:phone_monitor/tabs/sensors/sensors.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

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
            GetBuilder<HomeController>(
              builder: (homeController) => Row(
                children: [
                  GestureDetector(
                    onTap: () => homeController.goTo(5),
                    child: CustomCard(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/gyroscope.svg",
                              color: Theme.of(context).primaryColor,
                              height: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text("34", style: Get.textTheme.headline4),
                                Text(
                                  "Sensors Available",
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => homeController.goTo(4),
                      child: CustomCard(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.apps,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  "223",
                                  style: Get.textTheme.headline4,
                                ),
                                Text(
                                  "Apps installed",
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
