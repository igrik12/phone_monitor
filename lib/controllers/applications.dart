import 'package:device_apps/device_apps.dart';
import 'package:get/get.dart';

enum AppType { All, User, System }

extension SelectedAppType on AppType {
  String get displayValue {
    switch (this) {
      case AppType.All:
        return "All Apps";
      case AppType.User:
        return "User Apps";
      case AppType.System:
        return "System Apps";
        break;
      default:
        return "Unknown";
    }
  }
}

class ApplicationsController extends GetxController {
  var applications = List<Application>().obs;

  var _appType = AppType.All.obs;
  AppType get appType => _appType.value;
  void setAppType(AppType value) {
    _appType.value = value;
  }

  @override
  void onInit() async {
    super.onInit();
    applications.value = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeAppIcons: true,
        includeSystemApps: true);
  }
}
