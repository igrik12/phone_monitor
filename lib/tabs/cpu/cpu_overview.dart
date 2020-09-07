import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/custom_card.dart';
import 'package:system_info/system_info.dart';
import "package:collection/collection.dart";

class CpuOverview extends StatelessWidget {
  const CpuOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CPU Overview',
                      textScaleFactor: 1.3,
                    ),
                    GetX<CpuController>(
                        builder: (controller) => controller.cpuTemperature != -1
                            ? Text(
                                "${controller.cpuTemperature} °C",
                                style: TextStyle(color: Colors.blue),
                                textScaleFactor: 1.4,
                              )
                            : SizedBox())
                  ],
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: ,
                // ),
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
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.flash_on),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Frequencies'),
                        ],
                      ),
                      GetX<CpuController>(
                        builder: (cpuController) => ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: Get.width * 0.4),
                          child: Text(
                            _getGroupedFreq(cpuController),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )
                    ]),
              ],
            )));
  }

  String _getGroupedFreq(CpuController cpuController) {
    if (cpuController.cpuInfo == null) return "";
    var groupedByMax = groupBy(
        cpuController.cpuInfo.minMaxFrequencies.values, (obj) => obj.max);

    var joined = groupedByMax.entries
        .map((entry) => "${entry.value.length} x ${entry.key} Mhz")
        .join(', ');

    return joined;
  }
}
