import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:system_info/system_info.dart';

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
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'CPU Overview',
                    textScaleFactor: 1.3,
                  ),
                ),
                Divider(
                  height: 15,
                ),
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
                      SysInfo.processors.first.vendor ?? 'N/A',
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
                      GetX<CpuController>(
                          builder: (controller) => Text(
                                controller.cpuInfo?.numberOfCores?.toString() ??
                                    'N/A',
                              ))
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 3,
                          ),
                          SvgPicture.asset(
                            'assets/icons/cpu_hardware.svg',
                            height: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Architecture'),
                        ],
                      ),
                      Text(
                        SysInfo.processors.first.architecture.name ?? 'N/A',
                      )
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.code),
                          SizedBox(
                            width: 5,
                          ),
                          Text('ABIs'),
                        ],
                      ),
                      GetX<CpuController>(
                        builder: (cpuController) => Text(
                          cpuController.deviceInfo.supportedAbis.join(', '),
                        ),
                      )
                    ]),
              ],
            )));
  }
}
