import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/cpuChart.dart';

class Charts extends GetView<CpuController> {
  final chartsScrollController;

  const Charts({Key key, @required this.chartsScrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CpuController>(builder: (cpuController) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: CustomScrollView(
            shrinkWrap: true,
            controller: chartsScrollController,
            slivers: [
              SliverPadding(
                sliver: SliverToBoxAdapter(
                    child: Text('Cpu Frequency Charts',
                        style: TextStyle(fontSize: 16))),
                padding: EdgeInsets.only(bottom: 20),
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
                    return CpuChart(
                      minMax: cpuController.cpuInfo.minMaxFrequencies[index],
                      index: index,
                      stream: cpuController.stream,
                    );
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
