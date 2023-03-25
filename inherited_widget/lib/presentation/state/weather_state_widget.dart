import 'package:flutter/material.dart';

import '../../data/data_sources/api.dart';
import '../../data/repositories/weather_repository.dart';
import '../inherited_widgets/weather_inherited_widget.dart';
import 'context/weather_context.dart';

class WeatherStateWidget extends StatefulWidget {
  const WeatherStateWidget(
      {super.key, required this.child, required this.favouriteCity});

  final Widget child;
  final String favouriteCity;

  static WeatherStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<WeatherStateWidgetState>()!;
  }

  @override
  State<WeatherStateWidget> createState() => WeatherStateWidgetState();
}

class WeatherStateWidgetState extends State<WeatherStateWidget> {
  final WeatherRepository _weatherRepository;
  WeatherContext _weatherContext = WeatherContext(isLoading: true);

  WeatherStateWidgetState({WeatherRepository? weatherRepository})
      : _weatherRepository = weatherRepository ?? WeatherRepository();

  @override
  void initState() {
    super.initState();
    getWeeklyForecast(widget.favouriteCity);
  }

  Future<void> getWeeklyForecast(String cityName) async {
    try {
      setState(() {
        _weatherContext =
            _weatherContext.copyWith(isLoading: true, errorMessage: null);
      });
      final weeklyWeather =
          await _weatherRepository.getWeeklyForecast(cityName);
      setState(() {
        _weatherContext = _weatherContext.copyWith(
            isLoading: false, weeklyWeather: weeklyWeather, errorMessage: null);
      });
    } on GeocodingException {
      setState(() {
        _weatherContext = _weatherContext.copyWith(
            isLoading: false,
            errorMessage: 'Error! Couldn\'t fetch the location of that city.');
      });
    } on WeatherForecastException {
      setState(() {
        _weatherContext = _weatherContext.copyWith(
            isLoading: false,
            errorMessage: 'Error! Couldn\'t fetch the weather for that city.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WeatherInheritedWidget(_weatherContext, child: widget.child);
  }
}
