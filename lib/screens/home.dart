import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/homeController.dart';
import 'package:phone_monitor/tabs/cpu/cpu.dart';
import 'package:phone_monitor/tabs/applications/applications.dart';
import 'package:phone_monitor/tabs/dashboard/dashboard.dart';
import 'package:phone_monitor/tabs/display/display.dart';
import 'package:phone_monitor/tabs/sensors/sensors.dart';
import 'package:phone_monitor/tabs/system/system.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  HomeController homeController;
  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    _tabController = TabController(vsync: this, length: 6);
    homeController.setController(_tabController);
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
                    builder: (context) => new AlertDialog(
                      title: new Text('Are you sure?'),
                      content: new Text('Do you want to exit Phone Monitor?'),
                      actions: <Widget>[
                        OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text("No"),
                        ),
                        OutlineButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text("Yes")),
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
                    icon: Icon(Icons.settings),
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
      CpuTab(),
      System(),
      Display(),
      Applications(),
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
