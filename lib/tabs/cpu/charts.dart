import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:phone_monitor/widgets/cpuChart.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class Charts extends GetView<CpuController> {
  final chartsScrollController;

  const Charts({Key key, @required this.chartsScrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CpuController>(builder: (cpuController) {
      return CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: CustomScrollView(
            shrinkWrap: true,
            controller: chartsScrollController,
            slivers: [
              SliverToBoxAdapter(
                  child: Text(
                'Cpu Frequency Charts',
                style: Get.theme.textTheme.subtitle1,
              )),
              SliverToBoxAdapter(
                child: Divider(
                  height: 15,
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Get.context.isLandscape ? 4 : 2,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 1.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return GetBuilder<ThemeController>(
                        builder: (themeController) => CpuChart(
                              minMax: cpuController
                                  .cpuInfo.minMaxFrequencies[index],
                              index: index,
                              stream: cpuController.stream,
                              themMode: themeController.themeMode,
                            ));
                  },
                  childCount: cpuController.cpuInfo?.numberOfCores ?? 0,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
