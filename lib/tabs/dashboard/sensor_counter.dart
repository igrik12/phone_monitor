import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/homeController.dart';
import 'package:phone_monitor/utils/native_comms.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class SensorCounter extends GetView<HomeController> {
  const SensorCounter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.goTo(5),
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/gyroscope.svg",
                color: Theme.of(context).primaryColor,
                height: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              FutureBuilder<Map<dynamic, dynamic>>(
                  future: NativeComms.getSensors(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text("${snapshot.data.keys.length}",
                              style: Get.textTheme.headline4),
                          const Text(
                            "Sensors Available",
                          )
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
