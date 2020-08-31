import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/chart.dart';

class CpuTab extends StatelessWidget {
  CpuTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpuController>(
      init: CpuController(),
      builder: (cpuController) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Card(
                elevation: 2,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Overall Cpu Usage',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                    Text('${cpuController.overallUsage}%',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    backgroundColor: Colors.blue[50],
                                    value: cpuController.overallUsage / 100,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: '35 C',
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600)))
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.blur_circular),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Cpu Hardware'),
                            ],
                          ),
                          Text(
                            cpuController.deviceInfo?.hardware?.toUpperCase() ??
                                'N/A',
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.blur_on),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Cpu Cores'),
                              ],
                            ),
                            Text(
                              cpuController.cpuInfo.numberOfCores.toString() ??
                                  'N/A',
                            )
                          ]),
                      Row(),
                      Row()
                    ],
                  ),
                )),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 25,
          )),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.8,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CpuChart(
                  index: index,
                  stream: cpuController.stream,
                );
              },
              childCount: cpuController.cpuInfo?.numberOfCores ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
