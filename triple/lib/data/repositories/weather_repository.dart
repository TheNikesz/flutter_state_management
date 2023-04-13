import 'package:weather_app_triple/data/data_sources/api.dart';

import '../../domain/models/weather.dart';

class WeatherRepository {
  final GeocodingApi _geocodingApi;
  final WeatherForecastApi _weatherForecastApi;

  WeatherRepository({
    GeocodingApi? geocodingApi,
    WeatherForecastApi? weatherForecastApi,
  })  : _geocodingApi = geocodingApi ?? OpenMeteoGeocodingApi(),
        _weatherForecastApi =
            weatherForecastApi ?? OpenMeteoWeatherForecastApi();

  Future<List<Weather>> getWeeklyForecast(String cityName) async {
    try {
      final cityLocation = await _geocodingApi.getCityLocation(cityName);
      return await _weatherForecastApi.getWeeklyForecast(
          cityLocation.name, cityLocation.latitude, cityLocation.longitude);
    } catch (e) {
      rethrow;
    }
  }
}
