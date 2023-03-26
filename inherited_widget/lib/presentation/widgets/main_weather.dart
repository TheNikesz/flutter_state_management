import 'package:flutter/material.dart';
import 'package:weather_app_inherited_widget/domain/models/weather.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_labels.dart';
import '../../constants/unit_converter.dart';
import '../pages/weather_details_page.dart';

class MainWeather extends StatelessWidget {
  final Weather weather;
  final bool isNight;
  final bool isFahrenheit;

  const MainWeather({
    Key? key,
    required this.weather,
    required this.isNight,
    required this.isFahrenheit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WeatherDetailsPage(
                        weather: weather,
                        isNight: isNight,
                      )));
        },
        child: SizedBox(
          width: 360.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: BoxedIcon(
                      AppIcons.getWeatherIcon(weather.weatherCode, isNight),
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                      size: 80.0,
                    ),
                  ),
                  Text(
                    AppLabels.getWeatherLabel(weather.weatherCode),
                    style: TextStyle(
                      fontSize: 15,
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                    ),
                  ),
                ]),
              ),
              Center(
                child: SizedBox(
                  height: 150,
                  child: VerticalDivider(
                    color: isNight
                        ? AppColors.nightLightGray
                        : AppColors.dayDarkGray,
                    thickness: 3,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  isNight
                      ? UnitConverter.getTemperatureLabel(
                          weather.minTemperature, isFahrenheit)
                      : UnitConverter.getTemperatureLabel(
                          weather.maxTemperature, isFahrenheit),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
