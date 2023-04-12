import 'package:flutter/material.dart';
import 'package:weather_app_inherited_widget/presentation/state/chart_switch_state_widget.dart';

import '../../constants/app_colors.dart';

class ChartSwitch extends StatelessWidget {
  final bool isNight;
  final bool isChart;

  const ChartSwitch({
    Key? key,
    required this.isNight,
    required this.isChart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.reorder,
          color: isNight ? Colors.white : Colors.black,
        ),
        Switch(
          key: const Key('ChartSwitch'),
          hoverColor: Colors.transparent,
          activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
          activeTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
          inactiveThumbColor: isNight ? AppColors.dayDarkGray : Colors.black,
          inactiveTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
          value: isChart,
          onChanged: (value) {
            ChartSwitchStateWidget.of(context).changeGraphSwitchValue(value);
          },
        ),
        Icon(
          Icons.show_chart,
          color: isNight ? Colors.white : Colors.black,
        ),
      ],
    );
  }
}
