import 'package:flutter/material.dart';
import 'package:weather_app_bloc/domain/models/weather.dart';

import '../../constants/app_colors.dart';

class DetailsWeather extends StatelessWidget {
  final Weather weather;
  final bool isNight;

  const DetailsWeather({
    Key? key,
    required this.weather,
    required this.isNight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: SizedBox(
        width: 350.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    '${weather.maxTemperature.toStringAsFixed(0)}°',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 90,
                        color: isNight ? AppColors.nightText : AppColors.dayText,
                    ),
                  ),
                  Text(
                    'Maximum temp.',
                    style: TextStyle(
                      fontSize: 15,
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                    ),
                  ),
                ]
              ),
            ),
            Center(
              child: SizedBox(
                height: 130,
                child: VerticalDivider(
                  color: isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                  thickness: 3,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Text(
                    '${weather.minTemperature.toStringAsFixed(0)}°',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 90,
                        color: isNight ? AppColors.nightText : AppColors.dayText,
                    ),
                  ),
                  Text(
                    'Minimum temp.',
                    style: TextStyle(
                      fontSize: 15,
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}