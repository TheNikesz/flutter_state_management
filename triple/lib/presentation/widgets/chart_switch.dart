import 'package:flutter/material.dart';
import 'package:weather_app_triple/constants/app_colors.dart';
import 'package:weather_app_triple/main.dart';
import 'package:weather_app_triple/presentation/triple/weather_store.dart';

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
            getIt<WeatherStore>().changeGraphSwitchValue(value);
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
