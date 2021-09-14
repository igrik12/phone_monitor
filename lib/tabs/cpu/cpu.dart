import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/tabs/cpu/charts.dart';
import 'package:phone_monitor/tabs/cpu/cpu_progess_grid.dart';
import 'package:phone_monitor/tabs/cpu/cpu_overview.dart';
import 'package:phone_monitor/tabs/cpu/temp_chart.dart';
import 'package:phone_monitor/utils/ad_manager.dart';

class CpuTab extends StatefulWidget {
  const CpuTab({Key key}) : super(key: key);

  @override
  _CpuTabState createState() => _CpuTabState();
}

class _CpuTabState extends State<CpuTab> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
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
