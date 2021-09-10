import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';

import '../../widgets/chart_controller.dart';
import '../../widgets/custom_card.dart';

class TemperatureChart extends StatefulWidget {
  const TemperatureChart({Key key}) : super(key: key);

  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  ChartController chartController;
  StreamSubscription _streamSubscription;
  var temperature = 0.0;
  var initRun = true;

  @override
  void initState() {
    super.initState();
    chartController = _initCharts();
    _streamSubscription = CpuController.to.stream.listen((cpuData) {
      if (initRun) {
        for (var freq in tempCache) {
          chartController.addEntry(freq);
        }
        initRun = false;
      }
      var currentTemperature = cpuData.cpuTemperature;
      while (tempCache.length >= 100) {
        tempCache.removeFirst();
      }
      chartController.addEntry(currentTemperature);
      tempCache.addLast(currentTemperature);
      setState(() {
        temperature = currentTemperature;
      });
    });
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    chartController = _initCharts();
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
            SizedBox(
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
            const Divider(
              height: 20,
            ),
            SizedBox(
                height: 150,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: LineChart(chartController.controller)))
          ],
        ),
      ),
    );
  }
}
