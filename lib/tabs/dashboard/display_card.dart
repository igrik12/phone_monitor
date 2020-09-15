import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/controllers/homeController.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class DisplayCard extends GetView<DashboardController> {
  const DisplayCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<HomeController>().goTo(3),
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SvgPicture.asset(
                        'assets/icons/screen_measure.svg',
                        height: 35,
                      ))
                ],
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              Flexible(
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Screen Height', textScaleFactor: 1.2),
                            Text(
                                "${controller.wrapper.value.display.heightPixels} px",
                                textScaleFactor: 1.2)
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Screen Width', textScaleFactor: 1.2),
                            Text(
                                "${controller.wrapper.value.display.widthPixels} px",
                                textScaleFactor: 1.2)
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Density', textScaleFactor: 1.2),
                            Text(
                                "${controller.wrapper.value.display.densityDpi} ppi",
                                textScaleFactor: 1.2)
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Screen Size', textScaleFactor: 1.2),
                            Text(
                                "${controller.wrapper.value.display.screenSize} inch",
                                textScaleFactor: 1.2)
                          ],
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 1. Height
// 2. Width
// 3. DPI
// 4. Physical Size
