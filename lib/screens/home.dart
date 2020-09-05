import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:phone_monitor/tabs/cpu/cpu.dart';
import 'package:phone_monitor/tabs/dashboard/dashboard.dart';
import 'package:phone_monitor/widgets/customProgressIndicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              title: Text('Phone Monitor'),
              actions: [
                GetBuilder<ThemeController>(
                    builder: (themeController) => IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          themeController.setThemeMode(Get.isDarkMode
                              ? ThemeMode.light
                              : ThemeMode.dark);
                        }))
              ],
              bottom: TabBar(
                controller: tabController,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: _getTabs(),
              )),
          body: TabBarView(
            controller: tabController,
            children: getTabViewTabs(),
          ),
        ));
  }

  List<Widget> getTabViewTabs() {
    return <Widget>[
      Dashboard(),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: CpuTab(),
      ),
      GetX<CpuController>(
        builder: (_) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CustomProgressIndicator(
              type: ProgressIndicatorType.linear,
              value: _.overallUsage.toDouble() / 100,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _getTabs() {
    return [
      Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
      Tab(
        icon: Icon(Icons.shutter_speed),
        text: 'CPU',
      ),
      Tab(
        icon: Icon(Icons.memory),
        text: 'Memory',
      ),
    ];
  }
}
