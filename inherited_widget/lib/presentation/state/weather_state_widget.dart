import 'package:flutter/material.dart';

import '../../data/data_sources/api.dart';
import '../../data/repositories/weather_repository.dart';
import '../inherited_widgets/weather_inherited_widget.dart';
import 'weather_state.dart';

class WeatherStateWidget extends StatefulWidget {
  const WeatherStateWidget({super.key, required this.child});

  final Widget child;

  static WeatherStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<WeatherStateWidgetState>()!;
  }

  @override
  State<WeatherStateWidget> createState() => WeatherStateWidgetState();
}

class WeatherStateWidgetState extends State<WeatherStateWidget> {
  final WeatherRepository _weatherRepository;
  final WeatherState _weatherState;

  WeatherStateWidgetState(
      {WeatherRepository? weatherRepository, WeatherState? weatherState})
      : _weatherRepository = weatherRepository ?? WeatherRepository(),
        _weatherState = weatherState ?? WeatherState();

  Future<void> getWeeklyForecast(String cityName) async {
    try {
      setState(() {
        _weatherState.isLoading = true;
      });
      final weeklyWeather =
          await _weatherRepository.getWeeklyForecast(cityName);
      setState(() {
        _weatherState.isLoading = false;
        _weatherState.weeklyWeather = weeklyWeather;
      });
    } on GeocodingException {
      setState(() {
        _weatherState.isLoading = false;
        _weatherState.errorMessage =
            'Error! Couldn\'t fetch the location of that city.';
      });
    } on WeatherForecastException {
      setState(() {
        _weatherState.isLoading = false;
        _weatherState.errorMessage =
            'Error! Couldn\'t fetch the weather for that city.';
      });
    }
  }

  void changeGraphSwitchValue(bool value) {
    setState(() {
      _weatherState.isChart = value;
    });
  }

  void changeWeatherSwitchValue(bool value) {
    setState(() {
      _weatherState.isNight = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WeatherInheritedWidget(_weatherState, child: widget.child);
  }
}
