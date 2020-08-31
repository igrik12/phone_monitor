import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/home_controller.dart';
import 'package:phone_monitor/tabs/cpu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homecontroller) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                elevation: 5,
                title: Text('Phone Monitor'),
                bottom: TabBar(
                  controller: controller,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(icon: Icon(Icons.memory)),
                    Tab(icon: Icon(Icons.directions_transit)),
                    Tab(icon: Icon(Icons.directions_bike)),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    CpuTab(),
                    Text("Tab two"),
                    Text("Tab three"),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
