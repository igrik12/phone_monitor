import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/widgets/customProgressIndicator.dart';
import 'package:phone_monitor/widgets/progressWithPercentage.dart';
import 'package:phone_monitor/widgets/usageProgressDisplay.dart';

import 'storage_card.dart';

class Dashboard extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 2,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 26, horizontal: 10),
                child: Column(
                  children: [
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            UsageProgressDisplay(
                                title: "Memory",
                                value: controller.wrapper.value.totalRamUsage
                                        .toDouble() /
                                    100),
                            UsageProgressDisplay(
                              title: "Battery",
                              value: controller.wrapper.value.battery / 100,
                            ),
                            UsageProgressDisplay(
                              title: "Storage",
                              value: controller
                                      .wrapper.value.diskSpaceUsedInPersent /
                                  100,
                            )
                          ],
                        )),
                    Divider(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.phone_android,
                              size: 40,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Obx(() => Text(
                                  controller.deviceInfo?.device ?? "",
                                  textScaleFactor: 1.5,
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.android,
                              size: 40,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Obx(() => Text(
                                  "Android ${controller.deviceInfo?.version?.release}" ??
                                      "",
                                  textScaleFactor: 1.5,
                                ))
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: GetX<CpuController>(
                          builder: (cpuController) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ProgressWithPercentage(
                              value: cpuController.overallUsage?.overAll ?? 0.0,
                              title: "Overall Cpu Usage",
                              height: 16,
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            StorageCard()
          ],
        ),
      ),
    );
  }
}
