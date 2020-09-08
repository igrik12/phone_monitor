import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/utils/constants.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class System extends GetView<CpuController> {
  const System({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.phone_android,
                          size: 50,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.deviceInfo?.device ?? "",
                          textScaleFactor: 1.5,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.android,
                          size: 50,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Android ${controller.deviceInfo?.version?.release}" ??
                              "",
                          textScaleFactor: 1.5,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CustomCard(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: FutureBuilder<Map<String, String>>(
                    future: readAndroidBuildData(),
                    builder: (context, snapshot) {
                      final systemInfoMap = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: systemInfoMap.keys.length,
                              itemBuilder: (_, index) {
                                String key =
                                    systemInfoMap.keys.elementAt(index);
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "$key",
                                          textScaleFactor: 1.2,
                                        ),
                                        Container(
                                          width: Get.width * 0.35,
                                          child: Text(
                                            "${systemInfoMap[key]}",
                                            textAlign: TextAlign.left,
                                            textScaleFactor: 1.2,
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                );
                              }),
                        );
                      }
                      return Container(
                        height: Get.height * 0.6,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

Future<Map<String, String>> readAndroidBuildData() async {
  var build = await DeviceInfoPlugin().androidInfo;
  return <String, String>{
    'Manufacturer': build.manufacturer,
    'Model': build.model,
    'Brand': build.brand,
    'Product': build.product,
    'Sdk Version': build.version.sdkInt.toString(),
    'Board': build.board,
    'Bootloader': build.bootloader,
    'Device': build.device,
    'Display': build.display,
    'Hardware': build.hardware,
    'Build Id': build.id,
    'Supported32BitAbis': build.supported32BitAbis.join(', '),
    'Supported64BitAbis': build.supported64BitAbis.join(', '),
    'SupportedAbis': build.supportedAbis.join(', '),
  };
}
