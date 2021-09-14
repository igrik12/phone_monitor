import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/widgets/custom_progress_indicator.dart';

class UsageProgressDisplay extends StatelessWidget {
  final String title;
  final double value;

  const UsageProgressDisplay({
    Key key,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.width * 0.25,
          height: Get.width * 0.25,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Transform.rotate(
                  angle: -pi,
                  child: CustomProgressIndicator(
                    type: ProgressIndicatorType.circular,
                    value: value,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${(value * 100).toInt()} %',
                    style: const TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
