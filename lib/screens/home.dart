import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:phone_monitor/tabs/cpu/cpu.dart';
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
          duration: Duration(milliseconds: 500), curve: Curves.ease);
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
            GetBuilder<ThemeController>(
                builder: (themeController) => IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      themeController.setThemeMode(
                          Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                    }))
          ],
        ),
        body: PageView(
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
            Icon(
              FontAwesomeIcons.microchip,
              size: 25.0,
              color: Theme.of(context).accentColor,
            ),
            Icon(
              Icons.perm_device_information,
              size: 25.0,
              color: Theme.of(context).accentColor,
            ),
            Icon(
              Icons.gps_fixed,
              size: 25.0,
              color: Theme.of(context).accentColor,
            ),
          ],
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
      Sensors()
    ];
  }

  List<BottomNavigationBarItem> _getNavbarItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.dashboard), title: Text('Dashboard')),
      BottomNavigationBarItem(
        icon: Icon(Icons.shutter_speed),
        title: Text('CPU'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.perm_device_information),
        title: Text('System'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.gps_fixed),
        title: Text('Sensors'),
      )
    ];
  }
}
