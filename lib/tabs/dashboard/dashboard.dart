import 'package:flutter/material.dart';
import 'package:phone_monitor/widgets/usageProgressDisplay.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 2,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 26, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        UsageProgressDisplay(title: "RAM", value: 0.75),
                        UsageProgressDisplay(title: "Memory", value: 0.65),
                        UsageProgressDisplay(title: "Storage", value: 1)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.phone_android,
                              size: 40,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'One Plus 7T',
                              textScaleFactor: 1.5,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.android,
                              size: 40,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Android 10 Q',
                              textScaleFactor: 1.5,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
