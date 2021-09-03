import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';
import 'package:phone_monitor/controllers/homeController.dart';
import 'package:phone_monitor/controllers/themeController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CpuController>(CpuController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}
