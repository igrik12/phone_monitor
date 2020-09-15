import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class HardwareDescription extends StatelessWidget {
  const HardwareDescription({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: FutureBuilder<Map<String, String>>(
          future: readAndroidBuildData(),
          builder: (context, snapshot) {
            final systemInfoMap = snapshot.data;
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "System",
                      style: Get.theme.textTheme.subtitle1,
                    ),
                    Divider(
                      height: 20,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: systemInfoMap.keys.length,
                        itemBuilder: (_, index) {
                          String key = systemInfoMap.keys.elementAt(index);
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
                  ],
                ),
              );
            }
            return Container(
              height: Get.height * 0.6,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}

Future<Map<String, String>> readAndroidBuildData() async {
  var build = await DeviceInfoPlugin().androidInfo;
  return <String, String>{
    'Security Patch': build.version.securityPatch,
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
