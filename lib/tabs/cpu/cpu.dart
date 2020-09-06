import 'package:flutter/material.dart';
import 'package:phone_monitor/tabs/cpu/charts.dart';
import 'package:phone_monitor/tabs/cpu/cpuProgessGrid.dart';
import 'package:phone_monitor/tabs/cpu/cpu_overview.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          CpuOverview(),
          Card(
            elevation: 2,
            shadowColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: CpuProgressGrid(
                  chartsScrollController: _chartsScrollController,
                )),
          ),
          Charts(
            chartsScrollController: _chartsScrollController,
          ),
          TemperatureChart()
        ],
      ),
    );
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
