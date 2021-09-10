import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:phone_monitor/controllers/purchases_controller.dart';
import 'package:phone_monitor/tabs/system/system_overview.dart';
import 'package:phone_monitor/utils/ad_manager.dart';
import 'hardware_description.dart';

class System extends StatefulWidget {
  const System({Key key}) : super(key: key);

  @override
  _SystemState createState() => _SystemState();
}

class _SystemState extends State<System> {
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  @override
  void initState() {
    super.initState();
    if (Get.find<PurchasesController>().paid.value) return;
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
      padding: const EdgeInsets.all(8),
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
            const SystemOverview(),
            const HardwareDescription(),
            // DismissableAdBanner()
          ],
        ),
      ),
    );
  }
}
