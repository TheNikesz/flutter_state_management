import 'package:flutter/material.dart';
import 'package:weather_app_inherited_widget/presentation/state/settings_state_widget.dart';

import '../../constants/app_colors.dart';

class SettingsTemperatureScaleSwitch extends StatelessWidget {
  const SettingsTemperatureScaleSwitch({
    Key? key,
    required this.isNight,
    required this.isFahrenheit,
  }) : super(key: key);

  final bool isNight;
  final bool isFahrenheit;

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
                Text(
                  '°C',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isNight ? Colors.white : Colors.black,
                  ),
                ),
                Switch(
                  hoverColor: Colors.transparent,
                  activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
                  activeTrackColor:
                      isNight ? AppColors.dayLightGray : Colors.black87,
                  inactiveThumbColor:
                      isNight ? AppColors.dayDarkGray : Colors.black,
                  inactiveTrackColor:
                      isNight ? AppColors.dayLightGray : Colors.black87,
                  value: isFahrenheit,
                  onChanged: (value) {
                    SettingsStateWidget.of(context)
                        .changeSettingsTemperatureScaleSwitchValue(value);
                  },
                ),
                Text(
                  '°F',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isNight ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
