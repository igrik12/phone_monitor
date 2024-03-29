import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/utils/constants.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class SystemOverview extends GetView<CpuController> {
  const SystemOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Icon(
                  Icons.phone_android,
                  size: 50,
                  color: Colors.blue,
                ),
                const SizedBox(
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
                const Icon(
                  Icons.android,
                  size: 50,
                  color: kPrimaryColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Android ${controller.deviceInfo?.version?.release}" ?? "",
                  textScaleFactor: 1.5,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
