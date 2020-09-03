import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/cpuChart.dart';

class Charts extends StatelessWidget {
  final chartsScrollController;

  const Charts({Key key, @required this.chartsScrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpuController>(builder: (cpuController) {
      var boxConstraints = BoxConstraints(
          maxHeight: calcMaxHeight(cpuController.cpuInfo.numberOfCores) + 40);
      return ConstrainedBox(
        constraints: boxConstraints,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: CustomScrollView(
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
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 1.8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CpuChart(
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
        ),
      );
    });
  }
}

double calcMaxHeight(int numberOfCores) {
  return (numberOfCores / 2) * Get.height * 0.13;
}
