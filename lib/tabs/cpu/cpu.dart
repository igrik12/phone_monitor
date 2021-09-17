import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/tabs/cpu/charts.dart';
import 'package:phone_monitor/tabs/cpu/cpu_progess_grid.dart';
import 'package:phone_monitor/tabs/cpu/cpu_overview.dart';
import 'package:phone_monitor/tabs/cpu/temp_chart.dart';

class CpuTab extends StatefulWidget {
  const CpuTab({Key key}) : super(key: key);

  @override
  _CpuTabState createState() => _CpuTabState();
}

class _CpuTabState extends State<CpuTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            const CpuOverview(),
            const CpuProgressGrid(),
            // DismissableAdBanner(),
            const Charts(),
            CpuController.to.cpuInfo.cpuTemperature != -1
                ? const TemperatureChart()
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
