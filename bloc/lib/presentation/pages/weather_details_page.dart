import 'package:flutter/material.dart';
import 'package:weather_app_bloc/presentation/widgets/details_weather.dart';
import 'package:weather_app_bloc/presentation/widgets/weather_block.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_labels.dart';
import '../../domain/models/weather.dart';
import '../widgets/city_and_date.dart';

class WeatherDetailsPage extends StatelessWidget {
  final Weather weather;
  final bool isNight;

  const WeatherDetailsPage({
    Key? key,
    required this.weather,
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
          const Spacer(flex: 4,),
          _buildBackButton(context, isNight),
          CityAndDate(weather: weather, isNight: isNight,),
          const Spacer(),
          Column(
            children: [
              BoxedIcon(
                AppIcons.getWeatherIcon(weather.weatherCode, isNight),
                color: isNight ? Colors.white : Colors.black,
                size: 80.0,
              ),
              Text(
                AppLabels.getWeatherLabel(weather.weatherCode),
                style: TextStyle(
                  fontSize: 15,
                  color: isNight ? AppColors.nightText : AppColors.dayText,
                ),
              ),
            ],
          ),
          const Spacer(),
          DetailsWeather(weather: weather, isNight: isNight),
          const Spacer(),
          WeatherBlock(
            firstLabel: 'Max apparent temp.',
            isFirstIconWeather: true,
            firstIcon: WeatherIcons.thermometer,
            firstValue: '${weather.maxApparentTemperature.toStringAsFixed(0)}°',
            secondLabel: 'Min apparent temp.',
            isSecondIconWeather: true,
            secondIcon: WeatherIcons.thermometer_exterior,
            secondValue: '${weather.minApparentTemperature.toStringAsFixed(0)}°',
            isNight: isNight
          ),
          WeatherBlock(
            firstLabel: 'Sunrise',
            isFirstIconWeather: true,
            firstIcon: WeatherIcons.sunrise,
            firstValue: weather.sunrise,
            secondLabel: 'Sunset',
            isSecondIconWeather: true,
            secondIcon: WeatherIcons.sunset,
            secondValue: weather.sunset,
            isNight: isNight
          ),
          WeatherBlock(
            firstLabel: 'Rain sum',
            isFirstIconWeather: true,
            firstIcon: WeatherIcons.rain,
            firstValue: '${weather.rainSum.toStringAsFixed(0)} mm',
            secondLabel: 'Snowfall sum',
            isSecondIconWeather: true,
            secondIcon: WeatherIcons.snow,
            secondValue: '${weather.snowfallSum.toStringAsFixed(0)} mm',
            isNight: isNight
          ),
          WeatherBlock(
            firstLabel: 'Maximum wind speed',
            isFirstIconWeather: true,
            firstIcon: WeatherIcons.strong_wind,
            firstValue: '${weather.windSpeed.toStringAsFixed(0)} km/h',
            secondLabel: 'Dominant wind direction',
            isSecondIconWeather: false,
            secondIcon: AppIcons.getWindIcon(weather.windDirection),
            secondValue: AppLabels.getWindLabel(weather.windDirection),
            isNight: isNight
          ),
          const Spacer(),
        ],
      ),
    );
  }

  _buildBackButton(BuildContext context, bool isNight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isNight ? Colors.white : Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
