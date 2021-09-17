import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/homeController.dart';
import 'package:phone_monitor/controllers/tab_click_controller.dart';
import 'package:phone_monitor/tabs/cpu/cpu.dart';
import 'package:phone_monitor/tabs/applications/applications.dart';
import 'package:phone_monitor/tabs/dashboard/dashboard.dart';
import 'package:phone_monitor/tabs/display/display.dart';
import 'package:phone_monitor/tabs/sensors/sensors.dart';
import 'package:phone_monitor/tabs/system/system.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  HomeController homeController;
  bool initial = true;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    _tabController = TabController(vsync: this, length: 6);
    homeController.setController(_tabController);
    final clickController = Get.find<TabClickController>();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.index != _tabController.previousIndex) {
        clickController.click();
      }
    });

    clickController.clicked.stream.listen((clicks) {
      if (initial || clicks == 3) {
        initial = false;
        FacebookInterstitialAd.loadInterstitialAd(
          placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
          listener: (result, value) {
            if (result == InterstitialAdResult.LOADED)
              FacebookInterstitialAd.showInterstitialAd(delay: 500);
          },
        );
        clickController.resetClicks();
      }
    });
  }

  var tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: WillPopScope(
          onWillPop: () async {
            if (_tabController.index == 0) {
              return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Do you want to exit Phone Monitor?'),
                      actions: <Widget>[
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("No"),
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () => Get.back(),
                            child: const Text("Yes")),
                      ],
                    ),
                  ) ??
                  false;
            }
            _tabController.animateTo(0);
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Phone Monitor',
                style:
                    TextStyle(color: Theme.of(context).tabBarTheme.labelColor),
              ),
              bottom: TabBar(
                  controller: _tabController,
                  tabs: _buildTabs(context),
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Theme.of(context).tabBarTheme.labelColor),
              actions: [
                IconButton(
                    icon: Icon(Icons.settings,
                        color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      Get.toNamed("/settings");
                    }),
              ],
            ),
            body: TabBarView(
              children: _buildTabView(),
              controller: _tabController,
            ),
          ),
        ));
  }

  List<Widget> _buildTabView() {
    return [
      Dashboard(),
      const CpuTab(),
      const System(),
      const Display(),
      const Applications(),
      Sensors()
    ];
  }

  List<Widget> _buildTabs(BuildContext context) {
    return [
      Tab(
        text: "Dashboard",
        icon: Icon(Icons.dashboard,
            size: 25.0, color: Theme.of(context).iconTheme.color),
      ),
      Tab(
        text: "CPU",
        icon: SvgPicture.asset(
          'assets/icons/cpu_hardware.svg',
          color: Theme.of(context).iconTheme.color,
          height: 25,
        ),
      ),
      Tab(
        text: "System",
        icon: SvgPicture.asset('assets/icons/system_info.svg',
            height: 25, color: Theme.of(context).iconTheme.color),
      ),
      Tab(
        text: "Display",
        icon: SvgPicture.asset('assets/icons/phone_screen.svg',
            height: 25, color: Theme.of(context).iconTheme.color),
      ),
      Tab(
        text: "Apps",
        icon: Icon(Icons.apps,
            size: 25.0, color: Theme.of(context).iconTheme.color),
      ),
      Tab(
        text: "Sensors",
        icon: SvgPicture.asset(
          'assets/icons/gyroscope.svg',
          height: 25,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    ];
  }
}
