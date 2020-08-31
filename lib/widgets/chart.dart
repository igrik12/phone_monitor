import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/chartController.dart';

class CpuChart extends StatefulWidget {
  final int index;
  final Stream<Map<int, int>> stream;

  CpuChart({@required this.index, @required this.stream});

  @override
  _CpuChartState createState() => _CpuChartState();
}

class _CpuChartState extends State<CpuChart> {
  ChartController chartController;
  StreamSubscription _streamSubscription;
  var utilisation = '0%';
  var currentOutOfMax = 'N/A';

  @override
  void initState() {
    super.initState();
    final cpuController = Get.find<CpuController>();
    chartController = ChartController();
    _streamSubscription = widget.stream.listen((cpuData) {
      var currentFreq = cpuData[widget.index].toDouble();
      var max = cpuController.cpuInfo.minMaxFrequencies[widget.index].max;
      chartController.addEntry(currentFreq);
      setState(() {
        utilisation = '${(currentFreq * 100 / max).truncate()}%';
        currentOutOfMax = '$currentFreq mhz / $max mhz';
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _streamSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(utilisation), Text(currentOutOfMax)],
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LineChart(chartController.controller)))
      ],
    );
  }
}
