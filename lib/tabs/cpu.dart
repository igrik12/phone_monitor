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
        builder: (_) => Column(
              children: [
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 10,
                    )),
                Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Cpu Frequency Charts',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                            child: IgnorePointer(
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            padding: const EdgeInsets.all(8.0),
                            childAspectRatio: 1.5,
                            children: new List<Widget>.generate(
                                _.cpuInfo?.numberOfCores ?? 0,
                                (i) => CpuChart(
                                      index: i,
                                      stream: stream,
                                    )),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
