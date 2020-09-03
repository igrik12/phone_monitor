import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/progressBar.dart';

class CpuOverview extends StatelessWidget {
  const CpuOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(15),
          child: GetBuilder<CpuController>(
              builder: (cpuController) => Column(
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
                                CustomProgressIndicator(
                                  type: ProgressIndicatorType.linear,
                                  value: cpuController.overallUsage.toDouble() /
                                      100,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: '${cpuController.cpuTemperature} °C',
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
                              cpuController.cpuInfo.numberOfCores?.toString() ??
                                  'N/A',
                            )
                          ]),
                      Row(),
                      Row()
                    ],
                  )),
        ));
  }
}
