import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/custom_card.dart';
import 'package:phone_monitor/widgets/progress_with_percentage.dart';

class CpuProgressGrid extends StatelessWidget {
  const CpuProgressGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CpuController>(
        builder: (controller) => CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "CPU Core Usage",
                          style: Get.theme.textTheme.subtitle1,
                        )),
                    const Divider(
                      height: 15,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.cpuInfo.numberOfCores,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 12.0,
                          childAspectRatio: 3.5,
                        ),
                        itemBuilder: (_, index) =>
                            Obx(() => ProgressWithPercentage(
                                  height: 12,
                                  title:
                                      "cpu$index ${controller.cpuInfo.currentFrequencies[index].truncateToDouble()} mhz",
                                  value: controller
                                      .overallUsage.overAllPerCore[index],
                                ))),
                  ],
                ),
              ),
            ));
  }
}
