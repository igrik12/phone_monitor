import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/models/display_info.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class DisplayOverview extends StatelessWidget {
  const DisplayOverview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: GetX<DashboardController>(builder: (dbController) {
        final displayItems =
            _buildDisplayList(dbController.wrapper.value.display);
        return Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Display",
                style: Get.theme.textTheme.subtitle1,
              ),
              Divider(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: displayItems.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    String dispKey = displayItems.keys.elementAt(index);
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "$dispKey",
                              textScaleFactor: 1.2,
                            ),
                            Container(
                              width: Get.width * 0.35,
                              child: Text(
                                "${displayItems[dispKey]}",
                                textAlign: TextAlign.left,
                                textScaleFactor: 1.2,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      }),
    );
  }
}

Map<String, String> _buildDisplayList(DisplayInfo info) {
  return <String, String>{
    'Name': info.name,
    'Density': info.density.toString(),
    'Density DPI': info.densityDpi.toString(),
    'Scaled Density': info.scaledDensity.toString(),
    'Height': '${info.heightPixels.toString()} px',
    'Width': '${info.widthPixels.toString()} px',
    'xDpi': '${info.xdpi.toInt().toString()} px',
    'yDpi': '${info.ydpi.toInt().toString()} px',
    'Refresh Rate': '${info.refreshRate.toInt().toString()} fps',
    'HDR': info.isHrd ? 'Yes' : 'No'
  };
}
