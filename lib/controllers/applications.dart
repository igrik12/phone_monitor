import 'package:device_apps/device_apps.dart';
import 'package:get/get.dart';

enum AppType { all, user, system }

extension SelectedAppType on AppType {
  String get displayValue {
    switch (this) {
      case AppType.all:
        return "All Apps";
      case AppType.user:
        return "User Apps";
      case AppType.system:
        return "System Apps";
        break;
      default:
        return "Unknown";
    }
  }
}

class ApplicationsController extends GetxController {
  var applications = <Application>[].obs;

  final _appType = AppType.all.obs;
  AppType get appType => _appType.value;
  void setAppType(AppType value) {
    _appType.value = value;
  }

  @override
  void onInit() async {
    super.onInit();
    applications.value = await DeviceApps.getInstalledApplications(
        includeAppIcons: true, includeSystemApps: true);
  }
}
