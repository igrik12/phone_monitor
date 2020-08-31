import 'package:cpu_reader/cpu_reader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/chart.dart';

Stream<Map<int, int>> stream = CpuReader.cpuStream(500).asBroadcastStream();

class CpuTab extends StatelessWidget {
  CpuTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpuController>(
        init: CpuController(),
        builder: (_) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    '${_.abi}',
                  ),
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: new List<Widget>.generate(
                        _.coreCount,
                        (i) => CpuChart(
                              index: i,
                              stream: stream,
                            )),
                  )),
                ],
              ),
            ));
  }
}
