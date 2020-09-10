import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/controllers/dashboard_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CpuController>(CpuController(), permanent: true);
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
