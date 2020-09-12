import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/tabs/cpu/cpu.dart';
import 'package:phone_monitor/tabs/applications/applications.dart';
import 'package:phone_monitor/tabs/dashboard/dashboard.dart';
import 'package:phone_monitor/tabs/sensors/sensors.dart';
import 'package:phone_monitor/tabs/system/system.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Phone Monitor',
              style: TextStyle(color: Theme.of(context).tabBarTheme.labelColor),
            ),
            bottom: TabBar(
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
          body: TabBarView(children: _buildTabView()),
        ));
  }

  List<Widget> _buildTabView() {
    return [
      Dashboard(),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: CpuTab(),
      ),
      System(),
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
        text: "System Info",
        icon: SvgPicture.asset('assets/icons/system_info.svg',
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
