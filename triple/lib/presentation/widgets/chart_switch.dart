import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../cubits/weather_cubit.dart';

class ChartSwitch extends StatelessWidget {
  final bool isNight;
  final bool isGraph;

  const ChartSwitch({
    Key? key,
    required this.isNight,
    required this.isGraph,
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
          hoverColor: Colors.transparent,
          activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
          activeTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
          inactiveThumbColor: isNight ? AppColors.dayDarkGray : Colors.black,
          inactiveTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
          value: isGraph,
          onChanged: (value) {
            final weatherCubit = BlocProvider.of<WeatherCubit>(context);
            weatherCubit.changeGraphSwitchValue(value);
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