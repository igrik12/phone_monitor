import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/tabs/system/systemOverview.dart';
import 'package:phone_monitor/widgets/dismissableAdBanner.dart';

import 'displayOverview.dart';
import 'hardwareDescription.dart';

class System extends GetView<CpuController> {
  const System({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SystemOverview(),
            HardwareDescription(),
            DismissableAdBanner(),
            DisplayOverview()
          ],
        ),
      ),
    );
  }
}
