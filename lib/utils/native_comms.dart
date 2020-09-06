import 'package:flutter/services.dart';

class NativeComms {
  static const _channel = const MethodChannel('native_comms');
  static double _totalPhysicalMemory;

  /// Get total physical memory in MB
  static Future<double> getTotalPhysicalMemory() async {
    try {
      return _totalPhysicalMemory ??=
          await _channel.invokeMethod("getTotalPhysicalMemory") / 1024;
    } on PlatformException catch (e) {
      print("Failed to get total physical memory. ${e.message}");
      return -1;
    }
  }

  /// Gets virtual memory size in MB
  static Future<double> getVirtualMemorySize() async {
    try {
      int memoryInKb = await _channel.invokeMethod("getVirtualMemorySize");
      return memoryInKb / 1024;
    } on PlatformException catch (e) {
      print("Failed to get total physical memory. ${e.message}");
      return -1;
    }
  }

  static Future<int> getBatteryLevel() async {
    try {
      return await _channel.invokeMethod('getBatteryLevel');
    } on PlatformException catch (e) {
      print("Failed to retrieve battery level. ${e.message}");
      return -1;
    }
  }
}
