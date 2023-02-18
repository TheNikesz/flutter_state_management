import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class AppIcons {
  static IconData getWeatherIcon(int weatherCode, bool isNight) {
    if (isNight) {
      switch (weatherCode) {
        case 0:
          return WeatherIcons.night_clear;
        case 1:
        case 2:
        case 3:
          return WeatherIcons.night_alt_cloudy;
        case 45:
        case 48:
          return WeatherIcons.night_fog;
        case 51:
        case 53:
        case 55:
        case 80:
        case 81:
        case 82:
          return WeatherIcons.night_alt_showers;
        case 56:
        case 57:
          return WeatherIcons.night_alt_rain_mix;
        case 61:
        case 63:
        case 65:
          return WeatherIcons.night_alt_rain;
        case 66:
        case 67:
          return WeatherIcons.night_alt_sleet;
        case 71:
        case 73:
        case 75:
        case 77:
        case 85:
        case 86:
          return WeatherIcons.night_alt_snow;
        case 95:
          return WeatherIcons.night_alt_thunderstorm;
        case 96:
        case 99:
          return WeatherIcons.night_alt_snow_thunderstorm;
        default:
          return WeatherIcons.na;
      }
    }

    switch (weatherCode) {
      case 0:
        return WeatherIcons.day_sunny;
      case 1:
      case 2:
      case 3:
        return WeatherIcons.day_cloudy;
      case 45:
      case 48:
        return WeatherIcons.day_fog;
      case 51:
      case 53:
      case 55:
      case 80:
      case 81:
      case 82:
        return WeatherIcons.day_showers;
      case 56:
      case 57:
        return WeatherIcons.day_rain_mix;
      case 61:
      case 63:
      case 65:
        return WeatherIcons.day_rain;
      case 66:
      case 67:
        return WeatherIcons.day_sleet;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherIcons.day_snow;
      case 95:
        return WeatherIcons.day_thunderstorm;
      case 96:
      case 99:
        return WeatherIcons.day_snow_thunderstorm;
      default:
        return WeatherIcons.na;
    }
  }

  static IconData getWindIcon(int direction) {
    if (direction >= 23 && direction < 68) {
      return Icons.north_east;
    } else if (direction >= 68 && direction < 113) {
      return Icons.east;
    } else if (direction >= 113 && direction < 158) {
      return Icons.south_east;
    } else if (direction >= 159 && direction < 203) {
      return Icons.south;
    } else if (direction >= 203 && direction < 248) {
      return Icons.south_west;
    } else if (direction >= 248 && direction < 293) {
      return Icons.west;
    } else if (direction >= 293 && direction < 338) {
      return Icons.north_west_rounded;
    } else if (direction >= 338 && direction < 23) {
      return Icons.north;
    } else {
      return WeatherIcons.na;
    }
  }
}
