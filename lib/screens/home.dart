import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;
  PageController pageController;
  int bottomSelectedIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 600), curve: Curves.ease);
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    pageController = PageController(initialPage: 0);
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Phone Monitor'),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Get.toNamed("/settings");
                }),
          ],
        ),
        body: PageView(
          physics: AlwaysScrollableScrollPhysics(),
          pageSnapping: true,
          controller: pageController,
          children: getPages(),
          onPageChanged: (index) {
            pageChanged(index);
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: bottomSelectedIndex,
          items: [
            Icon(
              Icons.dashboard,
              size: 25.0,
              color: Theme.of(context).accentColor,
              //color: Colors.black,
            ),
            SvgPicture.asset(
              'assets/icons/cpu_hardware.svg',
              height: 25,
              color: Theme.of(context).accentColor,
            ),
            SvgPicture.asset(
              'assets/icons/system_info.svg',
              height: 25,
              color: Theme.of(context).accentColor,
            ),
            Icon(
              Icons.apps,
              size: 25.0,
              color: Theme.of(context).accentColor,
            ),
            SvgPicture.asset(
              'assets/icons/gyroscope.svg',
              height: 25,
              color: Theme.of(context).accentColor,
            ),
          ],
          height: 60,
          color: Theme.of(context).bottomAppBarColor,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            bottomTapped(index);
          },
        ));
  }

  List<Widget> getPages() {
    return <Widget>[
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
}
