import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/progressWithPercentage.dart';

class CpuProgressGrid extends StatelessWidget {
  final chartsScrollController;

  CpuProgressGrid({Key key, this.chartsScrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CpuController>(
        builder: (controller) => Container(
              child: GridView.count(
                controller: chartsScrollController,
                crossAxisSpacing: 10,
                childAspectRatio: 3.5,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: _buildCpuGrid(controller),
              ),
            ));
  }

  List<Widget> _buildCpuGrid(CpuController controller) {
    if (controller.cpuInfo == null || controller.overallUsage == null) {
      return List.generate(
          controller.cpuInfo?.numberOfCores,
          (index) => ProgressWithPercentage(
                height: 12,
                title: "cpu$index 0 mhz",
                value: 0.0,
              ));
    }
    return List.generate(
        controller.cpuInfo?.numberOfCores ?? 0,
        (index) => ProgressWithPercentage(
              height: 12,
              title:
                  "cpu$index ${controller.cpuInfo.currentFrequencies[index].truncateToDouble()} mhz",
              value: controller.overallUsage.overAllPerCore[index],
            ));
  }
}
