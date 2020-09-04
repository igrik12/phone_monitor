import 'dart:developer';

import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:cpu_reader/minMaxFreq.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

class CpuController extends GetxController {
  static CpuController get to => Get.find();

  // CPU information object
  Rx<CpuInfo> _cpuInfo = CpuInfo().obs..value.numberOfCores = 0;
  CpuInfo get cpuInfo => _cpuInfo.value;

  // Overall CPU usage in percentage
  var _overallUsage = 0.obs;
  int get overallUsage => _overallUsage.value;
  set overallUsage(int value) {
    _overallUsage.value = value;
  }

  // Overall CPU temperature
  var _cpuTemperature = 0.0.obs;
  double get cpuTemperature => _cpuTemperature.value;
  set cpuTemperature(double value) {
    _cpuTemperature.value = value;
  }

  Rx<AndroidDeviceInfo> _deviceInfo = Rx<AndroidDeviceInfo>();
  AndroidDeviceInfo get deviceInfo => _deviceInfo.value;
  set deviceInfo(AndroidDeviceInfo value) {
    _deviceInfo.value = value;
  }

  Stream<CpuInfo> stream = CpuReader.cpuStream(1500).asBroadcastStream();

  @override
  onInit() async {
    _cpuInfo.value = await CpuReader.cpuInfo;
    deviceInfo = await deviceInfoPlugin.androidInfo;
    stream.listen((cpuInfo) async {
      overallUsage = _calculateOverallUsage(cpuInfo);
      cpuTemperature = cpuInfo.cpuTemperature;
      update();
    });
    update();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
  }
}

int _calculateOverallUsage(CpuInfo info) {
  Timeline.startSync("Started computation");
  var totalCurrentUsageInMhz = info.currentFrequencies.values
      .reduce((value, element) => value + element);
  var totalMax = info.minMaxFrequencies.values
      .map((e) => e.max)
      .reduce((value, element) => value + element);
  Timeline.finishSync();
  return totalCurrentUsageInMhz * 100 ~/ totalMax;
}
