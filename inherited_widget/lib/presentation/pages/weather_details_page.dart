import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_labels.dart';
import '../../constants/unit_converter.dart';
import '../../domain/models/weather.dart';
import '../inherited_widgets/settings_inherited_widget.dart';
import '../widgets/city_and_date.dart';
import '../widgets/details_weather.dart';
import '../widgets/weather_block.dart';
import '../widgets/weather_details_back_button.dart';

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
    final settingsState = SettingsInheritedWidget.of(context);

    return Scaffold(
      backgroundColor: isNight == true ? AppColors.nightDarkBlue : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Stack(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: WeatherDetailsBackButton(
                isNight: isNight,
              ),
            ),
            Center(
                child: CityAndDate(
              weather: weather,
              isNight: isNight,
            )),
          ]),
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
          DetailsWeather(
            weather: weather,
            isNight: isNight,
            isFahrenheit: settingsState.isFahrenheit,
          ),
          const Spacer(),
          WeatherBlock(
              firstLabel: 'Max apparent temp.',
              isFirstIconWeather: true,
              firstIcon: WeatherIcons.thermometer,
              firstValue: UnitConverter.getTemperatureLabel(
                  weather.maxApparentTemperature, settingsState.isFahrenheit),
              secondLabel: 'Min apparent temp.',
              isSecondIconWeather: true,
              secondIcon: WeatherIcons.thermometer_exterior,
              secondValue: UnitConverter.getTemperatureLabel(
                  weather.minApparentTemperature, settingsState.isFahrenheit),
              isNight: isNight),
          WeatherBlock(
              firstLabel: 'Sunrise',
              isFirstIconWeather: true,
              firstIcon: WeatherIcons.sunrise,
              firstValue: UnitConverter.getHourLabel(
                  weather.sunrise, settingsState.isFahrenheit),
              secondLabel: 'Sunset',
              isSecondIconWeather: true,
              secondIcon: WeatherIcons.sunset,
              secondValue: UnitConverter.getHourLabel(
                  weather.sunset, settingsState.isFahrenheit),
              isNight: isNight),
          WeatherBlock(
              firstLabel: 'Rain sum',
              isFirstIconWeather: true,
              firstIcon: WeatherIcons.rain,
              firstValue: UnitConverter.getPrecipitationLabel(
                  weather.rainSum, settingsState.isFahrenheit),
              secondLabel: 'Snowfall sum',
              isSecondIconWeather: true,
              secondIcon: WeatherIcons.snow,
              secondValue: UnitConverter.getPrecipitationLabel(
                  weather.snowfallSum, settingsState.isFahrenheit),
              isNight: isNight),
          WeatherBlock(
              firstLabel: 'Max wind speed',
              isFirstIconWeather: true,
              firstIcon: WeatherIcons.strong_wind,
              firstValue: UnitConverter.getMaximumWindSpeedLabel(
                  weather.windSpeed, settingsState.isFahrenheit),
              secondLabel: 'Dominant wind dir.',
              isSecondIconWeather: false,
              secondIcon: AppIcons.getWindIcon(weather.windDirection),
              secondValue: AppLabels.getWindLabel(weather.windDirection),
              isNight: isNight),
          const Spacer(),
        ],
      ),
    );
  }
}
