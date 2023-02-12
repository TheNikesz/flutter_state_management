import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/api.dart';
import '../../data/repositories/weather_repository.dart';
import '../../domain/models/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
      : super(const WeatherInitial());

  Future<void> getWeeklyForecast(String cityName) async {
    try {
      emit(const WeatherLoading());
      final weeklyWeather = await weatherRepository.getWeeklyForecast(cityName);
      emit(WeatherSuccess(weeklyWeather: weeklyWeather));
    } on GeocodingException {
      emit(const WeatherFailure(
          'Error! Couldn\'t fetch the location of that city.'));
    } on WeatherForecastException {
      emit(const WeatherFailure(
          'Error! Couldn\'t fetch the weather for that city.'));
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
}
