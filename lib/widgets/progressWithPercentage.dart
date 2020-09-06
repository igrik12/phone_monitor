import 'package:flutter/material.dart';
import 'customProgressIndicator.dart';

class ProgressWithPercentage extends StatelessWidget {
  final double value;
  final String title;
  final double height;
  ProgressWithPercentage({this.value, this.title, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: this.height,
                )),
            Text('$value%',
                style: TextStyle(
                  fontSize: this.height,
                ))
          ],
        ),
        SizedBox(
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
