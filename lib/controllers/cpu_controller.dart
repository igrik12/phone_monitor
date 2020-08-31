import 'dart:async';

import 'package:cpu_reader/cpu_reader.dart';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

class CpuController extends GetxController {
  var frequencies = Map<int, int>();
  var frequencies2 = Map<int, int>();
  var coreCount = 0;
  var abi = '';
  Stream<Map<int, int>> stream = CpuReader.cpuStream(500).asBroadcastStream();
  // StreamSubscription _streamSubscription;

  @override
  onInit() async {
    // _streamSubscription = CpuReader.cpuStream(500).listen((event) {
    //   frequencies = event;
    //   update();
    // });

    var cores = await CpuReader.numberOfCores;
    abi = await CpuReader.abi;
    coreCount = cores;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    // _streamSubscription.cancel();
    // _streamSubscription = null;
  }
}
