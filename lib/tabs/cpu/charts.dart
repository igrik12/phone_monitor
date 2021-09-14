import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:phone_monitor/widgets/cpu_chart.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class Charts extends StatelessWidget {
  const Charts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CpuController>(builder: (cpuController) {
      return CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Column(
            children: [
              Text(
                'Cpu Frequency Charts',
                style: Get.theme.textTheme.subtitle1,
              ),
              const Divider(
                height: 15,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cpuController.cpuInfo.numberOfCores,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    childAspectRatio: 1.8,
                  ),
                  itemBuilder: (context, index) => GetBuilder<ThemeController>(
                      builder: (themeController) => CpuChart(
                            minMax:
                                cpuController.cpuInfo.minMaxFrequencies[index],
                            index: index,
                            stream: cpuController.stream,
                            themMode: themeController.themeMode,
                          )))
            ],
          ),
        ),
      );
    });
  }
}
