import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/tabs/system/systemOverview.dart';
import 'hardwareDescription.dart';

class System extends GetView<CpuController> {
  const System({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SystemOverview(),
            HardwareDescription(),
            // DismissableAdBanner(), DISABLED TILL THE APP KICKS OFF
          ],
        ),
      ),
    );
  }
}
