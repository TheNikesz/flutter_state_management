import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../cubits/settings_cubit.dart';
import '../widgets/favourite_city.dart';
import '../widgets/settings_chart_switch.dart';
import '../widgets/settings_weather_switch.dart';
import '../widgets/settings_temperature_scale_switch.dart';

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
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              FavouriteCity(isNight: isNight),
              SettingsTemperatureScaleSwitch(
                isNight: isNight,
                isFahrenheit: settingsState.isFahrenheit,
              ),
              SettingsChartSwitch(
                isNight: isNight,
                isChart: settingsState.isChart
              ),
              SettingsWeatherSwitch(
                isNight: isNight,
                isNightSettings: settingsState.isNight,
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
