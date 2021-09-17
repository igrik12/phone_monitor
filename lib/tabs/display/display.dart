import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/models/display_info.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class Display extends StatefulWidget {
  const Display({
    Key key,
  }) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: CustomCard(
        child: GetX<DashboardController>(builder: (dbController) {
          final displayItems =
              _buildDisplayList(dbController.wrapper.value.display);
          return Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: FacebookNativeAd(
                    placementId:
                        "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
                    adType: NativeAdType.NATIVE_BANNER_AD,
                    bannerAdSize: NativeBannerAdSize.HEIGHT_50,
                    width: double.infinity,
                    backgroundColor: Theme.of(context).primaryColor,
                    titleColor: Colors.white,
                    descriptionColor: Colors.white,
                    buttonColor: Colors.deepPurple,
                    buttonTitleColor: Colors.white,
                    buttonBorderColor: Colors.white,
                    listener: (result, value) {
                      print("Native Banner Ad: $result --> $value");
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Text(
                  "Display",
                  style: Get.theme.textTheme.subtitle1,
                ),
                const Divider(
                  height: 20,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: displayItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      String dispKey = displayItems.keys.elementAt(index);
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                dispKey,
                                textScaleFactor: 1.2,
                              ),
                              SizedBox(
                                width: Get.width * 0.35,
                                child: Text(
                                  displayItems[dispKey],
                                  textAlign: TextAlign.left,
                                  textScaleFactor: 1.2,
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          );
        }),
      ),
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
