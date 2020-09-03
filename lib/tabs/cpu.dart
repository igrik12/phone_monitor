import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:phone_monitor/controllers/cpu_controller.dart';
import 'package:phone_monitor/widgets/cpuChart.dart';
import 'package:phone_monitor/widgets/progressBar.dart';
import 'package:phone_monitor/widgets/tempChart.dart';

class CpuTab extends StatefulWidget {
  CpuTab({Key key}) : super(key: key);

  @override
  _CpuTabState createState() => _CpuTabState();
}

class _CpuTabState extends State<CpuTab> {
  ScrollController _mainScrollController;
  ScrollController _chartsScrollController;

  @override
  void initState() {
    super.initState();
    _mainScrollController = ScrollController();
    _chartsScrollController = ScrollController();
    _chartsScrollController.addListener(_chartsListener);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpuController>(
      init: CpuController(),
      builder: (cpuController) {
        var boxConstraints = BoxConstraints(
            maxHeight: calcMaxHeight(cpuController.cpuInfo.numberOfCores) + 40);
        return CustomScrollView(
          controller: _mainScrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                  elevation: 2,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Overall Cpu Usage',
                                          style: TextStyle(
                                            fontSize: 16,
                                          )),
                                      Text('${cpuController.overallUsage}%',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomProgressIndicator(
                                    title: 'Testing',
                                    type: ProgressIndicatorType.linear,
                                    value:
                                        cpuController.overallUsage.toDouble() /
                                            100,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: '${cpuController.cpuTemperature} °C',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600)))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.blur_circular),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Cpu Hardware'),
                              ],
                            ),
                            Text(
                              cpuController.deviceInfo?.hardware
                                      ?.toUpperCase() ??
                                  'N/A',
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.blur_on),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Cpu Cores'),
                                ],
                              ),
                              Text(
                                cpuController.cpuInfo.numberOfCores
                                        ?.toString() ??
                                    'N/A',
                              )
                            ]),
                        Row(),
                        Row()
                      ],
                    ),
                  )),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 25,
            )),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: boxConstraints,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    child: CustomScrollView(
                      controller: _chartsScrollController,
                      slivers: [
                        SliverPadding(
                          sliver: SliverToBoxAdapter(
                              child: Text('Cpu Frequency Charts',
                                  style: TextStyle(fontSize: 16))),
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.context.isLandscape ? 4 : 2,
                            mainAxisSpacing: 15.0,
                            crossAxisSpacing: 15.0,
                            childAspectRatio: 1.8,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return CpuChart(
                                index: index,
                                stream: cpuController.stream,
                              );
                            },
                            childCount:
                                cpuController.cpuInfo?.numberOfCores ?? 0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 25,
            )),
            SliverToBoxAdapter(
              child: TemperatureChart(
                stream: cpuController.stream,
              ),
            )
          ],
        );
      },
    );
  }

  double calcMaxHeight(int numberOfCores) {
    return (numberOfCores / 2) * Get.height * 0.13;
  }

  void _chartsListener() {
    if (_chartsScrollController.position.pixels ==
        _chartsScrollController.position.maxScrollExtent) {
      _mainScrollController.animateTo(
          _chartsScrollController.position.maxScrollExtent + 50,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
    } else if (_chartsScrollController.position.pixels ==
        _chartsScrollController.position.minScrollExtent) {
      _mainScrollController.animateTo(
          _chartsScrollController.position.pixels + 50,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
    }
  }
}
