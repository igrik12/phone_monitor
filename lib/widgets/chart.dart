import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
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

  @override
  void initState() {
    super.initState();
    chartController = ChartController();
    _streamSubscription = widget.stream.listen((cpuData) {
      chartController.addEntry(cpuData[widget.index].toDouble());
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
    return LineChart(chartController.controller);
  }
}
