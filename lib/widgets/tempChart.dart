import 'dart:async';

import 'package:cpu_reader/cpuinfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';

import 'chartController.dart';

class TemperatureChart extends StatefulWidget {
  final Stream<CpuInfo> stream;
  TemperatureChart({Key key, this.stream}) : super(key: key);

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
    chartController = ChartController();
    _streamSubscription = widget.stream.listen((cpuData) {
      var currentTemperature = cpuData.cpuTemperature;
      chartController.addEntry(currentTemperature);
      setState(() {
        temperature = currentTemperature;
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
                "Cpu Temparature",
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              Text(
                '$temperature °C',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            height: 150,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LineChart(chartController.controller)))
      ],
    );
  }
}
