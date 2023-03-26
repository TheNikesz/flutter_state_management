import 'package:dio/dio.dart';
import 'package:weather_app_inherited_widget/domain/models/location.dart';
import 'package:weather_app_inherited_widget/domain/models/weather.dart';

class GeocodingException implements Exception {}

class OpenMeteoGeocodingApi {
  static const _baseUrl = 'https://geocoding-api.open-meteo.com/v1/search';

  Future<Location> getCityLocation(String cityName) async {
    var response = await Dio()
        .get(_baseUrl, queryParameters: {'name': cityName, 'count': 1});

    if (response.data['results'] == null) {
      throw GeocodingException();
    }

    return Location.fromJson(response.data['results'][0]);
  }
}

class WeatherForecastException implements Exception {}

class OpenMeteoWeatherForecastApi {  
  static const _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<List<Weather>> getWeeklyForecast(
      String cityName, double latitude, double longitude) async {
    try {
      var response = await Dio().get(_baseUrl, queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'daily': [
          'weathercode',
          'temperature_2m_max',
          'temperature_2m_min',
          'apparent_temperature_max',
          'apparent_temperature_min',
          'sunrise',
          'sunset',
          'rain_sum',
          'snowfall_sum',
          'windspeed_10m_max',
          'winddirection_10m_dominant'
        ],
        'timezone': 'auto'
      });

      final dailyWeather = WeeklyWeather.fromJson(response.data).dailyWeather;
      List<Weather> weather = [];
      for (var i = 0; i < dailyWeather.dates.length; i++) {
        weather.add(Weather(
          cityName: cityName,
          date: dailyWeather.dates.elementAt(i),
          weatherCode: dailyWeather.weatherCodes.elementAt(i),
          minTemperature: dailyWeather.minTemperatures.elementAt(i),
          maxTemperature: dailyWeather.maxTemperatures.elementAt(i),
          minApparentTemperature:
              dailyWeather.minApparentTemperatures.elementAt(i),
          maxApparentTemperature:
              dailyWeather.maxApparentTemperatures.elementAt(i),
          sunrise: dailyWeather.sunrises.elementAt(i).substring(11),
          sunset: dailyWeather.sunsets.elementAt(i).substring(11),
          rainSum: dailyWeather.rainSums.elementAt(i),
          snowfallSum: dailyWeather.snowfallSums.elementAt(i),
          windSpeed: dailyWeather.windSpeeds.elementAt(i),
          windDirection: dailyWeather.windDirections.elementAt(i),
        ));
      }

      return weather;
    } on DioError {
      throw WeatherForecastException();
    }
  }
}
