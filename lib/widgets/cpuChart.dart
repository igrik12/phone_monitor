import 'dart:async';

import 'package:cpu_reader/cpuinfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/chartController.dart';

class CpuChart extends StatefulWidget {
  final int index;
  final Stream<CpuInfo> stream;

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
    chartController = ChartController(
        configuration: ChartControllerConfiguration(
            backgroundColor: Color.fromRGBO(242, 246, 247, 1)));
    _streamSubscription = widget.stream.listen((cpuData) {
      var currentFreq = cpuData.currentFrequencies[widget.index].toDouble();
      var max = cpuController.cpuInfo.minMaxFrequencies[widget.index].max;
      chartController.addEntry(currentFreq);
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
                style: TextStyle(color: Colors.blue),
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
