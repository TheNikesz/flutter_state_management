import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/data/data_sources/api.dart';
import 'package:weather_app_bloc/data/repositories/weather_repository.dart';

import '../../domain/models/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository, required String favouriteCity}) : super(WeatherInitial(favouriteCity: favouriteCity));

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
}
