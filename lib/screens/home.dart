import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/home_controller.dart';
import 'package:phone_monitor/tabs/cpu.dart';

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
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homecontroller) {
          return NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  title: Text('Phone Monitor'),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.shutter_speed),
                        text: 'CPU',
                      ),
                      Tab(
                        icon: Icon(Icons.memory),
                        text: 'Memory',
                      ),
                      Tab(icon: Icon(Icons.info), text: 'Info'),
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CpuTab(),
                ),
                Text("Tab two"),
                Text("Tab three"),
              ],
            ),
          );
        });
  }
}
