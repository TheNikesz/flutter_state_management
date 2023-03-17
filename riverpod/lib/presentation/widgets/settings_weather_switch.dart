import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/app_colors.dart';
import '../controllers/providers.dart';

class SettingsWeatherSwitch extends ConsumerWidget {
  const SettingsWeatherSwitch({
    Key? key,
    required this.isNight, required this.isNightSettings,
  }) : super(key: key);

  final bool isNight;
  final bool isNightSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
      child: SizedBox(
        height: 60,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isNight ? AppColors.nightLightBlue : AppColors.dayLightGray,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxedIcon(
                  WeatherIcons.day_sunny,
                  color: isNight ? Colors.white : Colors.black,
                ),
                Switch(
                  hoverColor: Colors.transparent,
                  activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
                  activeTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
                  inactiveThumbColor: isNight ? AppColors.dayDarkGray : Colors.black,
                  inactiveTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
                  value: isNightSettings,
                  onChanged: (value) async {
                    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
                    sharedPrefrences.setBool('isNight', value);
                    
                    ref.read(settingsProvider.notifier).state = ref.read(settingsProvider.notifier).state.copyWith(isNight: value);
                  },
                ),
                BoxedIcon(
                  WeatherIcons.night_clear,
                  color: isNight ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}