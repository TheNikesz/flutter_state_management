import 'package:flutter/material.dart';
import 'package:weather_app_inherited_widget/presentation/state/weather_switch_state_widget.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/app_colors.dart';

class WeatherSwitch extends StatelessWidget {
  final bool isNight;

  const WeatherSwitch({
    Key? key,
    required this.isNight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BoxedIcon(
          WeatherIcons.day_sunny,
          color: isNight ? Colors.white : Colors.black,
        ),
        Switch(
          hoverColor: Colors.transparent,
          activeColor: AppColors.dayDarkGray,
          activeTrackColor: AppColors.dayLightGray,
          inactiveThumbColor: Colors.black,
          inactiveTrackColor: Colors.black87,
          value: isNight,
          onChanged: (value) {
            WeatherSwitchStateWidget.of(context)
                .changeWeatherSwitchValue(value);
          },
        ),
        BoxedIcon(
          WeatherIcons.night_clear,
          color: isNight ? Colors.white : Colors.black,
        ),
      ],
    );
  }
}
