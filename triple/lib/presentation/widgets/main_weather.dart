import 'package:flutter/material.dart';
import 'package:weather_app_triple/constants/app_colors.dart';
import 'package:weather_app_triple/constants/app_icons.dart';
import 'package:weather_app_triple/constants/app_labels.dart';
import 'package:weather_app_triple/domain/models/weather.dart';
import 'package:weather_app_triple/presentation/pages/weather_details_page.dart';
import 'package:weather_icons/weather_icons.dart';

class MainWeather extends StatelessWidget {
  final Weather weather;
  final bool isNight;

  const MainWeather({
    Key? key,
    required this.weather,
    required this.isNight,
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
          width: 350.0,
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
                      color: isNight ? Colors.white : Colors.black,
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
                      ? '${weather.minTemperature.toStringAsFixed(0)}°'
                      : '${weather.maxTemperature.toStringAsFixed(0)}°',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 90,
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