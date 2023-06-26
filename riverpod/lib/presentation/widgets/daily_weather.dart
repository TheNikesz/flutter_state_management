import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/unit_converter.dart';
import '../../domain/models/weather.dart';
import '../pages/weather_details_page.dart';

class DailyWeather extends StatelessWidget {
  final Weather weather;
  final bool isNight;
  final bool isFahrenheit;

  const DailyWeather({
    Key? key,
    required this.weather,
    required this.isNight,
    required this.isFahrenheit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
      child: SizedBox(
        height: 60,
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
          child: DecoratedBox(
            decoration: BoxDecoration(
              color:
                  isNight ? AppColors.nightLightBlue : AppColors.dayLightGray,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('EEEE').format(DateTime.parse(weather.date)),
                      style: TextStyle(
                        color:
                            isNight ? AppColors.nightText : AppColors.dayText,
                      ),
                    ),
                  ),
                  Center(
                    child: BoxedIcon(
                      AppIcons.getWeatherIcon(weather.weatherCode, isNight),
                      size: 20.0,
                      color: isNight ? Colors.white : Colors.black,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        isNight ? UnitConverter.getTemperatureLabel(weather.minTemperature, isFahrenheit) : UnitConverter.getTemperatureLabel(weather.maxTemperature, isFahrenheit),
                        style: TextStyle(
                          color:
                              isNight ? AppColors.nightText : AppColors.dayText,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
