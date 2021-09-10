import 'package:flutter/services.dart';
import 'package:phone_monitor/models/display_info.dart';

class NativeComms {
  static const _channel =
      MethodChannel('com.twarkapps.phone_monitor/device_info');

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

  static Future<DisplayInfo> getDisplayData() async {
    try {
      var retrieved = await _channel.invokeMethod('getDisplayData');
      return DisplayInfo.fromJson(Map.from(retrieved));
    } on PlatformException catch (e) {
      print("Failed to retrieve display data. ${e.message}");
      return null;
    }
  }

  static Future<Map<dynamic, dynamic>> getSensors() async {
    try {
      var res = await _channel.invokeMethod("getSensorsList");
      return res;
    } on Exception catch (e) {
      print(e.toString());
      return <dynamic, dynamic>{};
    }
  }
}
