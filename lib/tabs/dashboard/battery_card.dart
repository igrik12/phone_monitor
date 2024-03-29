import 'package:battery_info/enums/charging_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/widgets/custom_progress_indicator.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class BatteryCard extends GetView<DashboardController> {
  const BatteryCard({Key key}) : super(key: key);

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
                Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: buildBatteryIcon(
                          controller.wrapper.value.battery.batteryLevel),
                    ))
              ],
            ),
            SizedBox(
              width: Get.width * 0.05,
            ),
            Flexible(
              child: Obx(
                () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Battery (${getBatteryChargeStatus(controller.wrapper.value.battery.chargingStatus)})",
                        textScaleFactor: 1.3,
                      ),
                      const SizedBox(
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
                                      .wrapper.value.battery.batteryLevel /
                                  100,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${controller.wrapper.value.battery.batteryLevel}%",
                            textScaleFactor: 1.3,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Voltage: ${controller.wrapper.value.battery.voltage}mV, Temperature: ${controller.wrapper.value.battery.temperature} °C")
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getBatteryChargeStatus(ChargingStatus status) {
    switch (status) {
      case ChargingStatus.Charging:
        return "Charging";
      case ChargingStatus.Discharging:
        return "Discharging";
      case ChargingStatus.Full:
        return "Full";
      default:
        return "Unknown";
    }
  }

  SvgPicture buildBatteryIcon(int level) {
    var path = "assets/icons/battery_full.svg";
    if ((level >= 10) & (level < 100)) {
      path = "assets/icons/battery_charging.svg";
    } else if (level < 10) {
      path = "assets/icons/battery_low.svg";
    }
    return SvgPicture.asset(
      path,
      height: 35,
    );
  }
}
