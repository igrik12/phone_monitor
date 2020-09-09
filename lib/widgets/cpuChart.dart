import 'dart:async';
import 'dart:collection';

import 'package:cpu_reader/cpuinfo.dart';
import 'package:cpu_reader/minMaxFreq.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/chartController.dart';

class CpuChart extends StatefulWidget {
  final int index;
  final Stream<CpuInfo> stream;
  final MinMaxFrequency minMax;

  final int cacheCount;

  CpuChart(
      {@required this.index,
      @required this.stream,
      this.minMax,
      this.cacheCount = 50});

  @override
  _CpuChartState createState() => _CpuChartState();
}

class _CpuChartState extends State<CpuChart> {
  ChartController chartController;
  StreamSubscription _streamSubscription;
  var utilisation = '0%';
  var currentOutOfMax = 'N/A';
  var initRun = true;

  @override
  void initState() {
    super.initState();
    final cpuController = Get.find<CpuController>();
    var minMaxFreq = widget.minMax;
    chartController = _initCharts(minMaxFreq);

    _streamSubscription = widget.stream.listen((cpuData) {
      if (initRun) {
        if (cache[widget.index] == null) {
          cache[widget.index] = Queue<double>();
        } else {
          cache[widget.index].forEach((freq) {
            chartController.addEntry(freq);
          });
        }
        initRun = false;
      }
      var currentFreq = cpuData.currentFrequencies[widget.index].toDouble();

      while (cache[widget.index].length >= widget.cacheCount) {
        cache[widget.index].removeFirst();
      }
      chartController.addEntry(currentFreq);
      var max = cpuController.cpuInfo.minMaxFrequencies[widget.index].max;
      cache[widget.index].addLast(currentFreq);
      setState(() {
        utilisation = '${(currentFreq * 100 / max).truncate()}%';
        currentOutOfMax = '${currentFreq.truncate()} mhz / $max mhz';
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _streamSubscription = null;
    super.dispose();
  }

  ChartController _initCharts(MinMaxFrequency minMaxFreq) {
    return ChartController(
        configuration: ChartControllerConfiguration(
            minY: 0,
            maxY: minMaxFreq.max.toDouble() + 150,
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            chartsColor: Get.theme.primaryColor));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              Text(
                utilisation,
              ),
              Text(currentOutOfMax)
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: LineChart(chartController.controller)))
      ],
    );
  }
}
