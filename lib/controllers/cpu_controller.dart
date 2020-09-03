import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';

DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

class CpuController extends GetxController {
  CpuInfo cpuInfo = CpuInfo()..numberOfCores = 0;
  AndroidDeviceInfo deviceInfo;
  int overallUsage = 0;
  double cpuTemperature = 0.0;
  Stream<CpuInfo> stream = CpuReader.cpuStream(1500).asBroadcastStream();

  @override
  onInit() async {
    cpuInfo = await CpuReader.cpuInfo;
    deviceInfo = await deviceInfoPlugin.androidInfo;
    stream.listen((cpuInfo) {
      overallUsage = _calculateOverallUsage(cpuInfo.currentFrequencies);
      cpuTemperature = cpuInfo.cpuTemperature;
      update();
    });
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  int _calculateOverallUsage(Map<int, int> currentFreq) {
    var totalCurrentUsageInMhz =
        currentFreq.values.reduce((value, element) => value + element);
    var totalMax = cpuInfo.minMaxFrequencies.values
        .map((e) => e.max)
        .reduce((value, element) => value + element);
    return totalCurrentUsageInMhz * 100 ~/ totalMax;
  }
}
