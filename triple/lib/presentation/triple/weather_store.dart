import 'package:flutter_triple/flutter_triple.dart';
import 'package:weather_app_triple/data/data_sources/api.dart';
import 'package:weather_app_triple/data/repositories/weather_repository.dart';

import '../../domain/models/weather.dart';

class WeatherStore extends Store<List<Weather>> {
  WeatherStore({WeatherRepository? weatherRepository})
      : _weatherRepository = weatherRepository ?? WeatherRepository(),
        super([]);

  final WeatherRepository _weatherRepository;

  Future<void> getWeeklyForecast(String cityName) async {
    setLoading(true);
    try {
      final weeklyWeather =
          await _weatherRepository.getWeeklyForecast(cityName);
      update(weeklyWeather);
    } on GeocodingException {
      setError(Exception('Error! Couldn\'t fetch the location of that city.'));
    } on WeatherForecastException {
      setError(Exception('Error! Couldn\'t fetch the weather for that city.'));
    }
    setLoading(false);
  }
}
