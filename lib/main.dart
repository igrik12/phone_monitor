import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_monitor/screens/home.dart';
import 'package:phone_monitor/utils/constants.dart';

import 'controllers/bindings.dart';
import 'utils/ad_manager.dart';

void main() async {
  await GetStorage.init();
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
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(color: Colors.orange),
          primaryColor: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          appBarTheme: AppBarTheme(color: kPrimaryColor),
          scaffoldBackgroundColor: Color.fromRGBO(242, 246, 247, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
