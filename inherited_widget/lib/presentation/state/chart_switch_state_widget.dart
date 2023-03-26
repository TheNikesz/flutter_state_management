import 'package:flutter/material.dart';
import 'package:weather_app_inherited_widget/presentation/inherited_widgets/chart_switch_inherited_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/context/chart_switch_context.dart';

class ChartSwitchStateWidget extends StatefulWidget {
  const ChartSwitchStateWidget(
      {Key? key, required this.child, required this.isChart})
      : super(key: key);

  final Widget child;
  final bool isChart;

  static ChartSwitchStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<ChartSwitchStateWidgetState>()!;
  }

  @override
  State<ChartSwitchStateWidget> createState() => ChartSwitchStateWidgetState();
}

class ChartSwitchStateWidgetState extends State<ChartSwitchStateWidget> {
  ChartSwitchContext _chartSwitchContext = ChartSwitchContext(isChart: false);

  @override
  void initState() {
    super.initState();
    setState(() {
      _chartSwitchContext = ChartSwitchContext(isChart: widget.isChart);
    });
  }

  void changeGraphSwitchValue(bool value) {
    setState(() {
      _chartSwitchContext = _chartSwitchContext.copyWith(isChart: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChartSwitchInheritedWidget(_chartSwitchContext, child: widget.child);
  }
}
