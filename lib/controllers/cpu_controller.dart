import 'dart:collection';
import 'dart:math';

import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';

final androidInfo = DeviceInfoPlugin().androidInfo;
final cache = Map<int, Queue<double>>();
final tempCache = Queue<double>();

class CpuController extends GetxController {
  static CpuController get to => Get.find();

  // Device info getter/setter
  Rx<AndroidDeviceInfo> _deviceInfo = Rx<AndroidDeviceInfo>();
  AndroidDeviceInfo get deviceInfo => _deviceInfo.value;
  set deviceInfo(AndroidDeviceInfo value) {
    _deviceInfo.value = value;
  }

  // CPU information object
  Rx<CpuInfo> _cpuInfo = CpuInfo().obs..value.numberOfCores = 0;
  CpuInfo get cpuInfo => _cpuInfo.value;

  // Overall CPU usage in percentage
  var _overallUsage = Rx<OverallUsage>();
  OverallUsage get overallUsage => _overallUsage.value;
  set overallUsage(OverallUsage value) {
    _overallUsage.value = value;
  }

  // Overall CPU temperature
  var _cpuTemperature = 0.0.obs;
  double get cpuTemperature => _cpuTemperature.value;
  set cpuTemperature(double value) {
    _cpuTemperature.value = value;
  }

  Stream<CpuInfo> stream = CpuReader.cpuStream(2000).asBroadcastStream();

  @override
  onInit() async {
    _cpuInfo.value = await CpuReader.cpuInfo;
    deviceInfo = await androidInfo;
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

// Calculate overall CPU usage for all cores
OverallUsage _calculateOverallUsage(CpuInfo info) {
  Map<int, double> overAllPerCore = Map<int, double>();
  var frequencies = info.currentFrequencies;
  var minMax = info.minMaxFrequencies;

  var totalCurrentUsage = 0;
  var totalMax = 0;

  for (var i = 0; i < frequencies.length; i++) {
    totalCurrentUsage += frequencies[i];
    totalMax += minMax[i].max;
    overAllPerCore[i] =
        (frequencies[i] * 100 / minMax[i].max).truncateToDouble();
  }

  var overAll = OverallUsage(
      overAll: (totalCurrentUsage * 100 / totalMax).truncateToDouble(),
      overAllPerCore: overAllPerCore);

  return overAll;
}

class OverallUsage {
  final double overAll;
  final Map<int, double> overAllPerCore;

  OverallUsage({this.overAll, this.overAllPerCore});
}
