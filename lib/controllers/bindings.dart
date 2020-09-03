import 'package:get/get.dart';
import 'package:phone_monitor/controllers/themeController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
  }
}
