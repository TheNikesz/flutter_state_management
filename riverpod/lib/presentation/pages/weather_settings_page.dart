import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../controllers/providers.dart';
import '../widgets/favourite_city.dart';
import '../widgets/settings_chart_switch.dart';
import '../widgets/settings_weather_switch.dart';
import '../widgets/settings_temperature_scale_switch.dart';

class WeatherSettingsPage extends ConsumerWidget {
  final bool isNight;

  const WeatherSettingsPage({
    Key? key,
    required this.isNight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: isNight == true ? AppColors.nightDarkBlue : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          FavouriteCity(isNight: isNight),
          SettingsTemperatureScaleSwitch(
            isNight: isNight,
            isFahrenheit: settings.isFahrenheit,
          ),
          SettingsChartSwitch(
            isNight: isNight,
            isChart: settings.isChart
          ),
          SettingsWeatherSwitch(
            isNight: isNight,
            isNightSettings: settings.isNight,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
