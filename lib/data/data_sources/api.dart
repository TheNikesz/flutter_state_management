import 'package:dio/dio.dart';
import 'package:weather_app_bloc/domain/models/location.dart';
import 'package:weather_app_bloc/domain/models/weather.dart';

class GeocodingException implements Exception {}

class OpenMeteoGeocodingApi {
  static const _baseUrl = 'https://geocoding-api.open-meteo.com/v1/search';

  Future<Location> getCityLocation(String cityName) async {
    var response = await Dio().get(_baseUrl, queryParameters: {'name' : cityName, 'count' : 1});

    print(response);

    if (response.data['results'] == null) {
      throw GeocodingException();
    }

    return Location.fromJson(response.data['results'][0]);
  }
}

class WeatherForecastException implements Exception {}

class OpenMeteoWeatherForecastApi {  
  static const _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<List<Weather>> getWeeklyForecast(double latitude, double longitude) async {
    var response = await Dio().get(_baseUrl, queryParameters: {'latitude' : latitude, 'longitude' : longitude, 'daily' : ['weathercode', 'temperature_2m_max', 'temperature_2m_min'], 'timezone' : 'auto'});

    if (response.statusCode != 200) {
      throw WeatherForecastException();
    }

    print(response.data);
    
    final dailyWeather = WeeklyWeather.fromJson(response.data).dailyWeather;
    List<Weather> weather = [];
    for (var i = 0; i < dailyWeather.dates.length; i++) {
      weather.add(
        Weather(
          date: dailyWeather.dates.elementAt(i), 
          weatherCode: dailyWeather.weatherCodes.elementAt(i), 
          minTemperature: dailyWeather.minTemperatures.elementAt(i), 
          maxTemperature: dailyWeather.maxTemperatures.elementAt(i)
        )
      );
    }

    return weather;
  }
}