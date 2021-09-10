import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/controllers/homeController.dart';
import 'package:phone_monitor/controllers/purchases_controller.dart';
import 'package:phone_monitor/controllers/tab_click_controller.dart';
import 'package:phone_monitor/controllers/themeController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CpuController>(CpuController());
    Get.lazyPut<TabClickController>(() => TabClickController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut(() => PurchasesController());
  }
}
