import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/models/display_info.dart';
import 'package:phone_monitor/utils/ad_manager.dart';
import 'package:phone_monitor/widgets/custom_card.dart';

class Display extends StatefulWidget {
  const Display({
    Key key,
  }) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  @override
  void initState() {
    super.initState();
    _bannerAd = AdManager.loadSmallBanner(() {
      setState(() {
        _isBannerAdReady = true;
      });
    }, (ad, err) {
      print('Failed to load a banner ad: ${err.message}');
      _isBannerAdReady = false;
      ad.dispose();
    });
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: CustomCard(
        child: GetX<DashboardController>(builder: (dbController) {
          final displayItems =
              _buildDisplayList(dbController.wrapper.value.display);
          return Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isBannerAdReady)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),
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
