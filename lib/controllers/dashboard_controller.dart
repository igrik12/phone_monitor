import 'package:device_info/device_info.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final deviceInfoPlugin = DeviceInfoPlugin().androidInfo;

  Rx<AndroidDeviceInfo> _deviceInfo = Rx<AndroidDeviceInfo>();
  AndroidDeviceInfo get deviceInfo => _deviceInfo.value;
  set deviceInfo(AndroidDeviceInfo value) {
    _deviceInfo.value = value;
  }

  @override
  void onInit() async {
    super.onInit();
    deviceInfo = await deviceInfoPlugin;
  }
}
