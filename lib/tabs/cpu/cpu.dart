import 'package:flutter/material.dart';
import 'package:phone_monitor/tabs/cpu/charts.dart';
import 'package:phone_monitor/tabs/cpu/cpuProgessGrid.dart';
import 'package:phone_monitor/tabs/cpu/cpu_overview.dart';
import 'package:phone_monitor/widgets/dismissableAdBanner.dart';

class CpuTab extends StatefulWidget {
  CpuTab({Key key}) : super(key: key);

  @override
  _CpuTabState createState() => _CpuTabState();
}

class _CpuTabState extends State<CpuTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CpuOverview(),
          DismissableAdBanner(),
          CpuProgressGrid(),
          Charts(),
          // CpuController.to.cpuInfo.cpuTemperature != -1
          //     ? TemperatureChart()
          //     : SizedBox()
        ],
      ),
    );
  }
}
