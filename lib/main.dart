import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:phone_monitor/screens/home.dart';
import 'package:phone_monitor/screens/settings.dart';

import 'controllers/bindings.dart';
import 'utils/ad_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.lazyPut<ThemeController>(() => ThemeController());
  Admob.initialize(AdManager.appId);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeController.to.themeMode,
      darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.amber,
          accentColor: Colors.amberAccent,
          tabBarTheme: TabBarTheme().copyWith(labelColor: Colors.black),
          iconTheme: IconThemeData().copyWith(color: Colors.black),
          primaryIconTheme: IconThemeData().copyWith(color: Colors.black),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.amber, fontSize: 18),
              bodyText2: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey[400]))),
      theme: ThemeData(
          primaryColor: Colors.blueAccent,
          tabBarTheme: TabBarTheme().copyWith(
              labelColor: Colors.white, indicatorSize: TabBarIndicatorSize.tab),
          iconTheme: IconThemeData().copyWith(color: Colors.black),
          primaryIconTheme: IconThemeData().copyWith(color: Colors.white),
          scaffoldBackgroundColor: Color.fromRGBO(242, 246, 247, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              subtitle1: TextStyle(fontSize: 18),
              bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
      home: Scaffold(
        body: Home(),
      ),
      getPages: [
        GetPage(name: '/settings', page: () => SettingsScreen()),
      ],
    );
  }
}
