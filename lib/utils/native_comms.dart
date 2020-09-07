import 'package:flutter/services.dart';
import 'package:phone_monitor/models/battery_info.dart';

class NativeComms {
  static const _channel =
      const MethodChannel('com.twarkapps.phone_monitor/device_info');
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

  /// Gets virtual memory size in MB
  static Future<double> getAvailableMemory() async {
    try {
      return await _channel.invokeMethod("getAvailableMemory") / (1024 * 1024);
    } on PlatformException catch (e) {
      print("Failed to get total physical memory. ${e.message}");
      return -1;
    }
  }

  /// Gets total virtual memory size in MB
  static Future<double> getTotalMemory() async {
    try {
      return await _channel.invokeMethod("getTotalMemory") / (1024 * 1024);
    } on PlatformException catch (e) {
      print("Failed to get total physical memory. ${e.message}");
      return -1;
    }
  }

  static Future<BatteryInfo> getBatteryData() async {
    try {
      var retrieved = await _channel.invokeMethod('getBatteryData');
      return BatteryInfo.fromJson(Map.from(retrieved));
    } on PlatformException catch (e) {
      print("Failed to retrieve battery level. ${e.message}");
      return null;
    }
  }
}
