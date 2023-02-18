import 'package:flutter_triple/flutter_triple.dart';
import 'package:weather_app_triple/data/data_sources/api.dart';
import 'package:weather_app_triple/data/repositories/weather_repository.dart';
import 'package:weather_app_triple/presentation/triple/weather_success.dart';

class WeatherStore extends StreamStore<Exception, WeatherSuccess> {
  WeatherStore({WeatherRepository? weatherRepository})
      : _weatherRepository = weatherRepository ?? WeatherRepository(),
        super(WeatherSuccess(weeklyWeather: []));

  final WeatherRepository _weatherRepository;

  Future<void> getWeeklyForecast(String cityName) async {
    setLoading(true);
    try {
      final weeklyWeather =
          await _weatherRepository.getWeeklyForecast(cityName);
      update(state.copyWith(weeklyWeather: weeklyWeather));
    } on GeocodingException {
      setError(Exception('Error! Couldn\'t fetch the location of that city.'));
    } on WeatherForecastException {
      setError(Exception('Error! Couldn\'t fetch the weather for that city.'));
    }
    setLoading(false);
  }

  void changeGraphSwitchValue(bool value) {
    update(state.copyWith(isChart: value));
  }

  void changeWeatherSwitchValue(bool value) {
    update(state.copyWith(isNight: value));
  }
}
