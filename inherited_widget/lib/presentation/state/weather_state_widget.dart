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
  WeatherState _weatherState = WeatherState();

  WeatherStateWidgetState({WeatherRepository? weatherRepository})
      : _weatherRepository = weatherRepository ?? WeatherRepository();

  @override
  void initState() {
    super.initState();
    getWeeklyForecast("Warsaw");
  }

  Future<void> getWeeklyForecast(String cityName) async {
    try {
      setState(() {
        _weatherState = _weatherState.copyWith(isLoading: true);
      });
      final weeklyWeather =
          await _weatherRepository.getWeeklyForecast(cityName);
      setState(() {
        _weatherState = _weatherState.copyWith(
            isLoading: false, weeklyWeather: weeklyWeather);
      });
    } on GeocodingException {
      setState(() {
        _weatherState = _weatherState.copyWith(
            isLoading: false,
            errorMessage: 'Error! Couldn\'t fetch the location of that city.');
      });
    } on WeatherForecastException {
      setState(() {
        _weatherState = _weatherState.copyWith(
            isLoading: false,
            errorMessage: 'Error! Couldn\'t fetch the weather for that city.');
      });
    }
  }

  void changeGraphSwitchValue(bool value) {
    setState(() {
      _weatherState = _weatherState.copyWith(isChart: value);
    });
  }

  void changeWeatherSwitchValue(bool value) {
    setState(() {
      _weatherState = _weatherState.copyWith(isNight: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WeatherInheritedWidget(_weatherState, child: widget.child);
  }
}
