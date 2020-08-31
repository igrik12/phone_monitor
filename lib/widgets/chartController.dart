import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp_chart/mp/controller/line_chart_controller.dart';
import 'package:mp_chart/mp/core/common_interfaces.dart';
import 'package:mp_chart/mp/core/data/line_data.dart';
import 'package:mp_chart/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_chart/mp/core/data_provider/line_data_provider.dart';
import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart/mp/core/description.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';
import 'package:mp_chart/mp/core/enums/legend_form.dart';
import 'package:mp_chart/mp/core/enums/mode.dart';
import 'package:mp_chart/mp/core/enums/y_axis_label_position.dart';
import 'package:mp_chart/mp/core/fill_formatter/i_fill_formatter.dart';
import 'package:mp_chart/mp/core/highlight/highlight.dart';
import 'package:mp_chart/mp/core/utils/color_utils.dart';

import 'constants.dart';

class ChartController implements OnChartValueSelectedListener {
  static const int VISIBLE_COUNT = 60;
  LineChartController controller;
  int _removalCounter = 0;

  ChartController() {
    initController();
  }

  @override
  void onNothingSelected() {}

  @override
  void onValueSelected(Entry e, Highlight h) {}

  void addEntry(double y0) {
    LineData data = controller.data;
    if (data != null) {
      ILineDataSet set0 = data.getDataSetByIndex(0);
      _addWithRemove(set0, data, y0);
      controller.setVisibleXRangeMaximum(VISIBLE_COUNT.toDouble());
      controller.moveViewToX(data.getEntryCount().toDouble());
      controller.state?.setStateIfNotDispose();
    }
  }

  void _addWithRemove(ILineDataSet set0, LineData data, double y0) {
    double x = (set0.getEntryCount() + _removalCounter).toDouble();
    data.addEntry(
        Entry(
          x: x,
          y: y0,
        ),
        0);
    //remove entry which is out of visible range
    if (set0.getEntryCount() > VISIBLE_COUNT) {
      data.removeEntry2(_removalCounter.toDouble(), 0);
      _removalCounter++;
    }
  }

  void initController() {
    var desc = Description()..enabled = false;
    controller = LineChartController(
        legendSettingFunction: (legend, controller) {
          (controller as LineChartController).setViewPortOffsets(0, 0, 0, 0);
          legend.enabled = (false);
          var data = (controller as LineChartController).data;
          if (data != null) {
            var formatter = data.getDataSetByIndex(0).getFillFormatter();
            if (formatter is A) {
              formatter.setPainter(controller);
            }
          }
        },
        xAxisSettingFunction: (xAxis, controller) {
          xAxis
            ..textColor = ColorUtils.WHITE
            ..drawGridLines = false
            ..avoidFirstLastClipping = true
            ..enabled = false;
          //xAxis.drawLabels = false;
        },
        axisLeftSettingFunction: (axisLeft, controller) {
          axisLeft
            ..setLabelCount2(2, false)
            ..textColor = Colors.transparent
            ..position = (YAxisLabelPosition.INSIDE_CHART)
            ..drawGridLines = (false)
            ..axisLineColor = (ColorUtils.WHITE);
        },
        axisRightSettingFunction: (axisRight, controller) {
          axisRight.enabled = (false);
        },
        drawGridBackground: true,
        dragXEnabled: true,
        dragYEnabled: true,
        scaleXEnabled: true,
        scaleYEnabled: true,
        pinchZoomEnabled: false,
        gridBackColor: Color.fromARGB(255, 104, 241, 175),
        backgroundColor: Color.fromARGB(255, 104, 241, 175),
        description: desc);

    LineData data = controller?.data;

    if (data == null) {
      data = LineData();
      controller.data = data;
      if (data != null) {
        ILineDataSet set0 = data.getDataSetByIndex(0);
        if (set0 == null) {
          set0 = _createSet(0);
          data.addDataSet(set0);
          for (var nn = 0; nn < VISIBLE_COUNT; nn++) {
            _addWithRemove(set0, data, 50);
            //controller.moveViewToX(data.getEntryCount().toDouble());
          }
        }
      }
    }
  }

  LineDataSet _createSet(int ix) {
    LineDataSet set = LineDataSet(null, "y$ix");

    set.setMode(Mode.CUBIC_BEZIER);
    set.setCubicIntensity(0.2);
    set.setDrawFilled(true);
    set.setDrawCircles(false);
    set.setDrawValues(false);
    set.setLineWidth(1.8);
    set.setHighLightColor(Color.fromARGB(255, 244, 117, 117));
    set.setColor1(ColorUtils.WHITE);
    set.setFillColor(ColorUtils.WHITE);
    set.setFillAlpha(100);
    set.setDrawHorizontalHighlightIndicator(false);
    set.setFillFormatter(A());
    return set;
  }
}

class A implements IFillFormatter {
  LineChartController _controller;

  void setPainter(LineChartController controller) {
    _controller = controller;
  }

  @override
  double getFillLinePosition(
      ILineDataSet dataSet, LineDataProvider dataProvider) {
    return _controller?.painter?.axisLeft?.axisMinimum;
  }
}
