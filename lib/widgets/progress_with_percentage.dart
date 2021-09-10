import 'package:flutter/material.dart';
import 'custom_progress_indicator.dart';

class ProgressWithPercentage extends StatelessWidget {
  final double value;
  final String title;
  final double height;
  const ProgressWithPercentage({Key key, this.value, this.title, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: height,
                )),
            Text('$value%',
                style: TextStyle(
                  fontSize: height,
                ))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomProgressIndicator(
          type: ProgressIndicatorType.linear,
          value: value / 100,
        )
      ],
    );
  }
}
