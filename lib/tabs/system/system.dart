import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:phone_monitor/tabs/system/system_overview.dart';
import 'hardware_description.dart';

class System extends StatefulWidget {
  const System({Key key}) : super(key: key);

  @override
  _SystemState createState() => _SystemState();
}

class _SystemState extends State<System> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
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
            const SystemOverview(),
            const HardwareDescription(),
            // DismissableAdBanner()
          ],
        ),
      ),
    );
  }
}
