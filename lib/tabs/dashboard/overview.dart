import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/utils/constants.dart';
import 'package:phone_monitor/widgets/custom_card.dart';
import 'package:phone_monitor/widgets/progress_with_percentage.dart';
import 'package:phone_monitor/widgets/usage_progress_display.dart';

class DashboardOverview extends GetView<DashboardController> {
  const DashboardOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 10),
        child: Column(
          children: [
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UsageProgressDisplay(
                        title: "Memory",
                        value: controller.wrapper.value.totalRamUsage / 100),
                    UsageProgressDisplay(
                      title: "Battery",
                      value:
                          controller.wrapper.value.battery.batteryLevel / 100,
                    ),
                    UsageProgressDisplay(
                      title: "Storage",
                      value:
                          controller.wrapper.value.diskSpaceUsedInPersent / 100,
                    )
                  ],
                )),
            const Divider(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.phone_android,
                      size: 40,
                      color: Colors.blue,
                    ),
                    const SizedBox(
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
                    const Icon(
                      Icons.android,
                      size: 40,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
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
            const Divider(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                    child: GetX<CpuController>(
                  builder: (cpuController) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ProgressWithPercentage(
                      value: cpuController?.overallUsage?.overAll ?? 0.0,
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
    );
  }
}
