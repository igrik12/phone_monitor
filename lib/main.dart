import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:phone_monitor/api/purchase_api.dart';
import 'package:phone_monitor/controllers/themeController.dart';
import 'package:phone_monitor/screens/google_sign_in.dart';
import 'package:phone_monitor/screens/home.dart';
import 'package:phone_monitor/screens/settings.dart';

import 'controllers/bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await MobileAds.instance.initialize();
  Get.lazyPut<ThemeController>(() => ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
          appBarTheme:
              const AppBarTheme().copyWith(backgroundColor: Colors.amber),
          tabBarTheme: const TabBarTheme().copyWith(labelColor: Colors.black),
          iconTheme: const IconThemeData().copyWith(color: Colors.black),
          primaryIconTheme: const IconThemeData().copyWith(color: Colors.black),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              subtitle1: const TextStyle(color: Colors.amber, fontSize: 18),
              bodyText2: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey[400]))),
      theme: ThemeData(
          primaryColor: Colors.blueAccent,
          tabBarTheme: const TabBarTheme().copyWith(
              labelColor: Colors.white, indicatorSize: TabBarIndicatorSize.tab),
          iconTheme: const IconThemeData().copyWith(color: Colors.black),
          primaryIconTheme: const IconThemeData().copyWith(color: Colors.white),
          scaffoldBackgroundColor: const Color.fromRGBO(242, 246, 247, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
              subtitle1: TextStyle(fontSize: 18),
              bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
      home: Scaffold(
        body: GSignInScreen(),
      ),
      getPages: [
        GetPage(name: '/settings', page: () => const SettingsScreen()),
      ],
    );
  }
}
