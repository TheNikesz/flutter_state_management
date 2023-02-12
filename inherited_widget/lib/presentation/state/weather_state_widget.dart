import 'package:flutter/material.dart';

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
  WeatherState _weatherState = WeatherState();

   final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository}) : super(const WeatherInitial());

  Future<void> getWeeklyForecast(String cityName) async {
    try {
      emit(const WeatherLoading());
      final weeklyWeather = await weatherRepository.getWeeklyForecast(cityName);
      emit(WeatherSuccess(
        weeklyWeather: weeklyWeather
      ));
    } on GeocodingException {
      emit(const WeatherFailure('Error! Couldn\'t fetch the location of that city.'));
    } on WeatherForecastException {
      emit(const WeatherFailure('Error! Couldn\'t fetch the weather for that city.'));
    }
  }

  void changeGraphSwitchValue(bool value) {
    if (state is WeatherSuccess) {
      emit((state as WeatherSuccess).copyWith(
        isChart: value,
      ));
    }
  }

  void changeWeatherSwitchValue(bool value) {
    if (state is WeatherSuccess) {
      emit((state as WeatherSuccess).copyWith(
        isNight: value,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WeatherInheritedWidget(_weatherState, child: widget.child);
  }
}
