import 'package:weather_app_bloc/data/data_sources/api.dart';
import 'package:weather_app_bloc/domain/models/location.dart';

import '../../domain/models/weather.dart';

class WeatherRepository {
  final OpenMeteoGeocodingApi _geocodingApi;
  final OpenMeteoWeatherForecastApi _weatherForecastApi;
  
  WeatherRepository({
    OpenMeteoGeocodingApi? geocodingApi,
    OpenMeteoWeatherForecastApi? weatherForecastApi,
  }) : _geocodingApi = geocodingApi ?? OpenMeteoGeocodingApi(), _weatherForecastApi = weatherForecastApi ?? OpenMeteoWeatherForecastApi();

  Future<List<Weather>> getWeeklyForecast(String city) async {
    final cityLocation = await _geocodingApi.getCityLocation(city);
    return await _weatherForecastApi.getWeeklyForecast(cityLocation.latitude, cityLocation.longitude);
  }
}
