import 'package:flutter/material.dart';

import '../state/context/chart_switch_context.dart';

class ChartSwitchInheritedWidget extends InheritedWidget {
  const ChartSwitchInheritedWidget(this.chartSwitchContext,
      {Key? key, required Widget child})
      : super(key: key, child: child);

  final ChartSwitchContext chartSwitchContext;

  static ChartSwitchContext of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChartSwitchInheritedWidget>()!
        .chartSwitchContext;
  }

  @override
  bool updateShouldNotify(ChartSwitchInheritedWidget oldWidget) {
    return chartSwitchContext != oldWidget.chartSwitchContext;
  }
}
