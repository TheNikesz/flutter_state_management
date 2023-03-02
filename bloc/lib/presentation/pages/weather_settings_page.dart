import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../widgets/favourite_city.dart';
import '../widgets/settings_chart_switch.dart';
import '../widgets/settings_weather_switch.dart';
import '../widgets/temperature_scale_switch.dart';

class WeatherSettingsPage extends StatelessWidget {
  final bool isNight;

  const WeatherSettingsPage({
    Key? key,
    required this.isNight,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isNight == true ? AppColors.nightDarkBlue : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          FavouriteCity(isNight: isNight),
          TemperatureScaleSwitch(isNight: isNight),
          SettingsChartSwitch(isNight: isNight),
          SettingsWeatherSwitch(isNight: isNight),
          const Spacer(),
        ],
      ),
    );
  }
}