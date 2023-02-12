import '../../domain/models/weather.dart';
import '../data_sources/api.dart';

class WeatherRepository {
  final OpenMeteoGeocodingApi _geocodingApi;
  final OpenMeteoWeatherForecastApi _weatherForecastApi;

  WeatherRepository({
    OpenMeteoGeocodingApi? geocodingApi,
    OpenMeteoWeatherForecastApi? weatherForecastApi,
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
