import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/widgets/customProgressIndicator.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class StorageCard extends GetView<DashboardController> {
  const StorageCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(
                  Icons.sd_storage,
                  color: Colors.blue,
                  size: 35,
                )
              ],
            ),
            SizedBox(
              width: Get.width * 0.05,
            ),
            Flexible(
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Internal Storage",
                        textScaleFactor: 1.3,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomProgressIndicator(
                              type: ProgressIndicatorType.linear,
                              value: controller
                                      .wrapper.value.diskSpaceUsedInPersent /
                                  100,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${controller.wrapper.value.diskSpaceUsedInPersent}%",
                            textScaleFactor: 1.3,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Used: ${controller.wrapper.value.diskSpaceUsed} GB, Total: ${controller.totalDiskSpace} GB")
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
