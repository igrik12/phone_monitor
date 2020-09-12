import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:phone_monitor/widgets/cpuChart.dart';
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
              Divider(
                height: 15,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cpuController.cpuInfo.numberOfCores,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
// SliverChildBuilderDelegate(
//                     (BuildContext context, int index) {
//                       return GetBuilder<ThemeController>(
//                           builder: (themeController) => CpuChart(
//                                 minMax: cpuController
//                                     .cpuInfo.minMaxFrequencies[index],
//                                 index: index,
//                                 stream: cpuController.stream,
//                                 themMode: themeController.themeMode,
//                               ));
//                     },
//                     childCount: cpuController.cpuInfo?.numberOfCores ?? 0,
//                   )
// CustomScrollView(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             slivers: [
//               SliverToBoxAdapter(
//                   child: Text(
//                 'Cpu Frequency Charts',
//                 style: Get.theme.textTheme.subtitle1,
//               )),
//               SliverToBoxAdapter(
//                 child: Divider(
//                   height: 15,
//                 ),
//               ),
//               SliverGrid(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: Get.context.isLandscape ? 4 : 2,
//                   mainAxisSpacing: 12.0,
//                   crossAxisSpacing: 12.0,
//                   childAspectRatio: 1.8,
//                 ),
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     return GetBuilder<ThemeController>(
//                         builder: (themeController) => CpuChart(
//                               minMax: cpuController
//                                   .cpuInfo.minMaxFrequencies[index],
//                               index: index,
//                               stream: cpuController.stream,
//                               themMode: themeController.themeMode,
//                             ));
//                   },
//                   childCount: cpuController.cpuInfo?.numberOfCores ?? 0,
//                 ),
//               )
//             ],
//           ),
