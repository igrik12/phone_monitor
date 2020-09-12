import 'package:flutter/material.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/tabs/cpu/charts.dart';
import 'package:phone_monitor/tabs/cpu/cpuProgessGrid.dart';
import 'package:phone_monitor/tabs/cpu/cpu_overview.dart';
import 'package:phone_monitor/tabs/cpu/tempChart.dart';
import 'package:phone_monitor/widgets/dismissableAdBanner.dart';

class CpuTab extends StatefulWidget {
  CpuTab({Key key}) : super(key: key);

  @override
  _CpuTabState createState() => _CpuTabState();
}

class _CpuTabState extends State<CpuTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CpuOverview(),
            // DismissableAdBanner(), // DISABLED TILL THE APP KICKS OFF
            CpuProgressGrid(),
            Charts(),
            CpuController.to.cpuInfo.cpuTemperature != -1
                ? TemperatureChart()
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
