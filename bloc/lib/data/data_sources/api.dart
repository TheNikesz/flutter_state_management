import 'package:dio/dio.dart';
import 'package:weather_app_bloc/domain/models/location.dart';
import 'package:weather_app_bloc/domain/models/weather.dart';

abstract class GeocodingApi {
  GeocodingApi();

  Future<Location> getCityLocation(String cityName);
}

class GeocodingException implements Exception {}

class OpenMeteoGeocodingApi implements GeocodingApi {
  static const _baseUrl = 'https://geocoding-api.open-meteo.com/v1/search';

  @override
  Future<Location> getCityLocation(String cityName) async {
    var response = await Dio().get(_baseUrl, queryParameters: {'name' : cityName, 'count' : 1});

    if (response.data['results'] == null) {
      throw GeocodingException();
    }

    return Location.fromJson(response.data['results'][0]);
  }
}

class GeocodingApiMock implements GeocodingApi {
  @override
  Future<Location> getCityLocation(String cityName) async {
    final Map<String, dynamic> data;
    switch (cityName) {
      case 'Warsaw': {
        data = {
          "results": [
            {
              "id": 756135,
              "name": "Warsaw",
              "latitude": 52.22977,
              "longitude": 21.01178,
              "elevation": 113.0,
              "feature_code": "PPLC",
              "country_code": "PL",
              "admin1_id": 858787,
              "admin2_id": 6695624,
              "admin3_id": 7531926,
              "timezone": "Europe/Warsaw",
              "population": 1702139,
              "country_id": 798544,
              "country": "Poland",
              "admin1": "Masovian",
              "admin2": "Warszawa",
              "admin3": "Warsaw"
            }
          ],
        };
      }
      break;
      case 'Lublin': {
        data = {
          "results": [
            {
              "id": 765876,
              "name": "Lublin",
              "latitude": 51.25,
              "longitude": 22.56667,
              "elevation": 183.0,
              "feature_code": "PPLA",
              "country_code": "PL",
              "admin1_id": 858785,
              "admin2_id": 7530970,
              "admin3_id": 7532869,
              "timezone": "Europe/Warsaw",
              "population": 360044,
              "country_id": 798544,
              "country": "Poland",
              "admin1": "Lublin",
              "admin2": "Lublin",
              "admin3": "Lublin"
            }
          ],
        };
      }
      break;
      default: {
        await Future.delayed(const Duration(milliseconds: 500));
        throw GeocodingException();
      }
    }

    final location = Location.fromJson(data['results'][0]);

    return Future.delayed(const Duration(milliseconds: 500), () => location);
  }
}

abstract class WeatherForecastApi {
  Future<List<Weather>> getWeeklyForecast(String cityName, double latitude, double longitude);
}

class WeatherForecastException implements Exception {}

class OpenMeteoWeatherForecastApi implements WeatherForecastApi {  
  static const _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  @override
  Future<List<Weather>> getWeeklyForecast(String cityName, double latitude, double longitude) async {
    try {
      var response = await Dio().get(_baseUrl, queryParameters: {'latitude' : latitude, 'longitude' : longitude, 'daily' : ['weathercode', 'temperature_2m_max', 'temperature_2m_min', 'apparent_temperature_max', 'apparent_temperature_min', 'sunrise', 'sunset', 'rain_sum', 'snowfall_sum', 'windspeed_10m_max', 'winddirection_10m_dominant'], 'timezone' : 'auto'});
      
      final dailyWeather = WeeklyWeather.fromJson(response.data).dailyWeather;
      List<Weather> weather = [];
      for (var i = 0; i < dailyWeather.dates.length; i++) {
        weather.add(
          Weather(
            cityName: cityName,
            date: dailyWeather.dates.elementAt(i), 
            weatherCode: dailyWeather.weatherCodes.elementAt(i), 
            minTemperature: dailyWeather.minTemperatures.elementAt(i), 
            maxTemperature: dailyWeather.maxTemperatures.elementAt(i),
            minApparentTemperature: dailyWeather.minApparentTemperatures.elementAt(i), 
            maxApparentTemperature: dailyWeather.maxApparentTemperatures.elementAt(i),
            sunrise: dailyWeather.sunrises.elementAt(i).substring(11),
            sunset: dailyWeather.sunsets.elementAt(i).substring(11),
            rainSum: dailyWeather.rainSums.elementAt(i),
            snowfallSum: dailyWeather.snowfallSums.elementAt(i),
            windSpeed: dailyWeather.windSpeeds.elementAt(i),
            windDirection: dailyWeather.windDirections.elementAt(i),
          )
        );
      }

      return weather;
    } on DioError {
      throw WeatherForecastException();
    }
  }
}

class WeatherForecastApiMock implements WeatherForecastApi {
  @override
  Future<List<Weather>> getWeeklyForecast(String cityName, double latitude, double longitude) async {    
    final Map<String, dynamic> data;
    switch (cityName) {
      case 'Warsaw': {
        data = {
          "daily": {
            "time": ["2023-03-22", "2023-03-23", "2023-03-24", "2023-03-25", "2023-03-26", "2023-03-27", "2023-03-28"],
            "weathercode": [3, 61, 61, 3, 3, 3, 85],
            "temperature_2m_max": [11.8, 16.6, 16.9, 14.1, 11.2, 6.5, 2.7],
            "temperature_2m_min": [2.7, 8.2, 10.3, 7.8, 5.5, 0.9, -1.2],
            "apparent_temperature_max": [9.8, 14.2, 15.1, 11.0, 6.8, 2.8, -3.0],
            "apparent_temperature_min": [-0.0, 6.5, 9.1, 5.2, 2.8, -3.0, -6.2],
            "sunrise": ["2023-03-22T05:32", "2023-03-23T05:30", "2023-03-24T05:27", "2023-03-25T05:25", "2023-03-26T05:23", "2023-03-27T05:20", "2023-03-28T05:18"],
            "sunset": ["2023-03-22T17:53", "2023-03-23T17:55", "2023-03-24T17:56", "2023-03-25T17:58", "2023-03-26T18:00", "2023-03-27T18:02", "2023-03-28T18:03"],
            "rain_sum": [0.00, 0.30, 2.80, 0.00, 0.00, 0.00, 0.00],
            "snowfall_sum": [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2.10],
            "windspeed_10m_max": [11.3, 13.0, 12.5, 12.6, 18.5, 18.1, 21.1],
            "winddirection_10m_dominant": [177, 218, 215, 238, 254, 298, 293]
          }
        };
      }
      break;
      case 'Lublin': {
        data = {
          "daily": {
            "time": ["2023-03-22", "2023-03-23", "2023-03-24", "2023-03-25", "2023-03-26", "2023-03-27", "2023-03-28"],
            "weathercode": [45, 61, 61, 3, 80, 61, 85],
            "temperature_2m_max": [12.5, 17.1, 16.2, 14.0, 11.0, 6.4, 2.8],
            "temperature_2m_min": [2.1, 8.2, 10.5, 7.7, 5.1, 0.4, -2.1],
            "apparent_temperature_max": [9.2, 14.2, 14.0, 11.3, 6.7, 4.5, -3.2],
            "apparent_temperature_min": [-0.2, 5.8, 8.4, 5.3, 2.7, -4.2, -7.9],
            "sunrise": ["2023-03-22T05:26", "2023-03-23T05:24", "2023-03-24T05:21", "2023-03-25T05:19", "2023-03-26T05:17", "2023-03-27T05:15", "2023-03-28T05:12"],
            "sunset": ["2023-03-22T17:46", "2023-03-23T17:48", "2023-03-24T17:50", "2023-03-25T17:51", "2023-03-26T17:53", "2023-03-27T17:55", "2023-03-28T17:56"],
            "rain_sum": [0.00, 0.10, 0.60, 0.00, 0.00, 6.90, 0.00],
            "snowfall_sum": [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 2.10],
            "windspeed_10m_max": [13.1, 17.4, 14.8, 12.0, 18.1, 21.3, 26.8],
            "winddirection_10m_dominant": [194, 217, 207, 257, 258, 309, 293]
          }
        };
      }
      break;
      default: {
        await Future.delayed(const Duration(milliseconds: 500));
        throw WeatherForecastException();
      }
    }

    final dailyWeather = WeeklyWeather.fromJson(data).dailyWeather;

    List<Weather> weather = [];
    for (var i = 0; i < dailyWeather.dates.length; i++) {
      weather.add(
        Weather(
          cityName: cityName,
          date: dailyWeather.dates.elementAt(i), 
          weatherCode: dailyWeather.weatherCodes.elementAt(i), 
          minTemperature: dailyWeather.minTemperatures.elementAt(i), 
          maxTemperature: dailyWeather.maxTemperatures.elementAt(i),
          minApparentTemperature: dailyWeather.minApparentTemperatures.elementAt(i), 
          maxApparentTemperature: dailyWeather.maxApparentTemperatures.elementAt(i),
          sunrise: dailyWeather.sunrises.elementAt(i).substring(11),
          sunset: dailyWeather.sunsets.elementAt(i).substring(11),
          rainSum: dailyWeather.rainSums.elementAt(i),
          snowfallSum: dailyWeather.snowfallSums.elementAt(i),
          windSpeed: dailyWeather.windSpeeds.elementAt(i),
          windDirection: dailyWeather.windDirections.elementAt(i),
        )
      );
    }

    return Future.delayed(const Duration(milliseconds: 500), () => weather);
  }
}