import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/app_colors.dart';
import '../cubits/settings_cubit.dart';

class SettingsWeatherSwitch extends StatelessWidget {
  const SettingsWeatherSwitch({
    Key? key,
    required this.isNight, required this.isNightSettings,
  }) : super(key: key);

  final bool isNight;
  final bool isNightSettings;

  @override
  Widget build(BuildContext context) {
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
                  key: const Key('SettingsWeatherSwitch'),
                  hoverColor: Colors.transparent,
                  activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
                  activeTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
                  inactiveThumbColor: isNight ? AppColors.dayDarkGray : Colors.black,
                  inactiveTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
                  value: isNightSettings,
                  onChanged: (value) {
                    final settingsCubit = BlocProvider.of<SettingsCubit>(context);
                    settingsCubit.changeSettingsWeatherSwitchValue(value);
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