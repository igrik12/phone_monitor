import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(242, 246, 247, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              bodyText2: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
