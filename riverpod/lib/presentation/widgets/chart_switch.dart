import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../controllers/providers.dart';

class ChartSwitch extends ConsumerWidget {
  final bool isNight;
  final bool isChart;

  const ChartSwitch({
    Key? key,
    required this.isNight,
    required this.isChart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.reorder,
          color: isNight ? Colors.white : Colors.black,
        ),
        Switch(
          hoverColor: Colors.transparent,
          activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
          activeTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
          inactiveThumbColor: isNight ? AppColors.dayDarkGray : Colors.black,
          inactiveTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
          value: isChart,
          onChanged: (value) => ref.read(chartSwitchProvider.notifier).state = value
        ),
        Icon(
          Icons.show_chart,
          color: isNight ? Colors.white : Colors.black,
        ),
      ],
    );
  }
}