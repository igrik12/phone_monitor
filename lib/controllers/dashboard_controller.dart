import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:disk_space/disk_space.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/utils/native_comms.dart';

class DashboardController extends GetxController {
  final deviceInfoPlugin = DeviceInfoPlugin().androidInfo;
  Rx<AndroidDeviceInfo> _deviceInfo = Rx<AndroidDeviceInfo>();
  AndroidDeviceInfo get deviceInfo => _deviceInfo.value;
  set deviceInfo(AndroidDeviceInfo value) {
    _deviceInfo.value = value;
  }

  Timer _timer;
  int totalPhysicalMemory;
  // Memory wrapper observable
  final wrapper = DashboardInfoWrapper().obs
    ..value.totalRamUsage = 100
    ..value.battery = 100
    ..value.diskSpaceUsed = 100;

  @override
  void onInit() async {
    super.onInit();
    totalPhysicalMemory = await NativeComms.getTotalPhysicalMemory();
    print(pid);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      var totalVirtual = await NativeComms.getVirtualMemorySize();
      var totalUsedInPersent =
          calcMemoryUsage(totalPhysicalMemory, totalVirtual);
      var diskSpaceUsed = await calcDiskSpaceUsed();
      var battery = await NativeComms.getBatteryLevel();
      wrapper.update((value) {
        value.totalRamUsage = totalUsedInPersent;
        value.battery = battery;
        value.diskSpaceUsed = diskSpaceUsed;
      });
    });
    deviceInfo = await deviceInfoPlugin;
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    _timer.cancel();
    _timer = null;
  }
}

Future<int> calcDiskSpaceUsed() async {
  final free = await DiskSpace.getFreeDiskSpace;
  final total = await DiskSpace.getTotalDiskSpace;
  final used = total - free;
  return used * 100 ~/ total;
}

int calcMemoryUsage(int totalPhysicalMemory, int virtualMemory) {
  return virtualMemory * 100 ~/ totalPhysicalMemory;
}

class DashboardInfoWrapper {
  int totalRamUsage = 100;
  int battery = 100;
  int diskSpaceUsed = 100;
}
