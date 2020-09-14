import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TabController tabController;

  void setController(TabController controller) {
    tabController = controller;
    update();
  }

  void goTo(int index) {
    tabController.animateTo(index, duration: Duration(milliseconds: 300));
  }
}
