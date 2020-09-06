import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:disk_space/disk_space.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/models/dashboard_wrapper.dart';
import 'package:phone_monitor/utils/native_comms.dart';

class DashboardController extends GetxController {
  final deviceInfoPlugin = DeviceInfoPlugin().androidInfo;
  Rx<AndroidDeviceInfo> _deviceInfo = Rx<AndroidDeviceInfo>();
  AndroidDeviceInfo get deviceInfo => _deviceInfo.value;
  set deviceInfo(AndroidDeviceInfo value) {
    _deviceInfo.value = value;
  }

  Timer _timer;
  double totalPhysicalMemory = 0;
  double totalDiskSpace = 0;

  // Memory wrapper observable
  final wrapper = DashboardInfoWrapper().obs
    ..value.totalRamUsage = 100
    ..value.battery = 100
    ..value.diskSpaceUsedInPersent = 100;

  @override
  void onInit() async {
    super.onInit();
    deviceInfo = await deviceInfoPlugin;
    totalPhysicalMemory = await NativeComms.getTotalPhysicalMemory();
    totalDiskSpace = (await DiskSpace.getTotalDiskSpace / 1024).toPrecision(2);
    print(pid);
    _timer = Timer.periodic(Duration(seconds: 1), dashboardHandler);
  }

  /// This handles the retrieval of the Dashboard relevant information,
  /// such as RAM memory, storage and battery life
  void dashboardHandler(timer) async {
    var totalVirtual = await NativeComms.getVirtualMemorySize();
    var totalMemoryUsedInPersent =
        calcMemoryUsage(totalPhysicalMemory, totalVirtual);
    final totalDiskSpaceAvailable =
        (await DiskSpace.getFreeDiskSpace / 1024).toPrecision(2);
    var diskSpaceUsedInPersent =
        await calcDiskSpaceUsed(totalDiskSpace, totalDiskSpaceAvailable);
    var battery = await NativeComms.getBatteryLevel();

    /// Runs an update on the [DashboardWrapper.obs]
    wrapper.update((value) {
      // RAM memory
      value.totalRamUsage = totalMemoryUsedInPersent;
      value.totalSpaceAvailable = totalPhysicalMemory;

      // Disk space
      value.diskSpaceUsed = totalDiskSpace - totalDiskSpaceAvailable;
      value.diskSpaceUsedInPersent = diskSpaceUsedInPersent;
      value.totalDiskSpaceAvailable = totalDiskSpaceAvailable;

      value.battery = battery;
    });
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    _timer.cancel();
    _timer = null;
  }
}

/// Calculate disk space used from [total] and [free]
Future<int> calcDiskSpaceUsed(double total, double free) async {
  final used = total - free;
  return used * 100 ~/ total;
}

/// Calculate current memory usagr from [totalPhysicalMemory] and [virtualMemory]
int calcMemoryUsage(double totalPhysicalMemory, double virtualMemory) {
  return virtualMemory * 100 ~/ totalPhysicalMemory;
}
