import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';

import '../../widgets/chartController.dart';
import '../../widgets/custom_card.dart';

class TemperatureChart extends StatefulWidget {
  TemperatureChart({Key key}) : super(key: key);

  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  ChartController chartController;
  StreamSubscription _streamSubscription;
  var temperature = 0.0;

  @override
  void initState() {
    super.initState();
    chartController = _initCharts();
    _streamSubscription = CpuController.to.stream.listen((cpuData) {
      var currentTemperature = cpuData.cpuTemperature;
      chartController.addEntry(currentTemperature);
      setState(() {
        temperature = currentTemperature;
      });
    });
  }

  ChartController _initCharts() {
    return ChartController(
        configuration: ChartControllerConfiguration(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            chartsColor: Get.theme.primaryColor,
            minY: 10,
            maxY: 75));
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _streamSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text(
                    "Cpu Temparature",
                    style: Get.theme.textTheme.subtitle1,
                  ),
                  Text(
                    '$temperature °C',
                    style: Get.theme.textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
                height: 150,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: LineChart(chartController.controller)))
          ],
        ),
      ),
    );
  }
}
