import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/homeController.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class AppCounter extends GetView<HomeController> {
  const AppCounter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.goTo(4),
      child: CustomCard(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Icon(
              Icons.apps,
              size: 50,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            FutureBuilder<List<Application>>(
                future: DeviceApps.getInstalledApplications(
                  includeSystemApps: true,
                ),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          "${snapshot.data.length}",
                          style: Get.textTheme.headline4,
                        ),
                        const Text(
                          "Apps installed",
                        )
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      )),
    );
  }
}
