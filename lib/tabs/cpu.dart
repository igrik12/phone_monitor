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
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: Get.width * 0.98,
                    height: 100,
                    color: Colors.greenAccent,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Cpu Frequency Charts',
                            style: TextStyle(
                                fontSize: 16,
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
                            padding: const EdgeInsets.all(12.0),
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
                Card(
                  elevation: 2,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    height: 120,
                  ),
                )
              ],
            ));
  }
}
