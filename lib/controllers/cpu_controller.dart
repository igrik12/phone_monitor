import 'dart:async';

import 'package:cpu_reader/cpu_reader.dart';
import 'package:cpu_reader/cpuinfo.dart';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

class CpuController extends GetxController {
  CpuInfo cpuInfo;

  @override
  onInit() async {
    cpuInfo = await CpuReader.cpuInfo;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
