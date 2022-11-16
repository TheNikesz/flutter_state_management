class AppLabels {
  static String getWeatherLabel(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
        return 'Partly cloudy';
      case 2:
        return 'Mainly clear';
      case 3:
        return 'Overcast';
      case 45:
        return 'Fog';
      case 48:
        return 'Depositing rime fog';
      case 51:
        return 'Light drizzle';
      case 53:
        return 'Moderate drizzle';
      case 55:
        return 'Dense drizzle';
      case 56:
        return 'Light freezing drizzle';
      case 57:
        return 'Dense freezing drizzle';
      case 61:
        return 'Slight rain';
      case 63:
        return 'Moderate rain';
      case 65:
        return 'Heavy rain';
      case 66:
        return 'Light freezing rain';
      case 67:
        return 'Heavy freezing rain';
      case 71:
        return 'Slight snow fall';
      case 73:
        return 'Moderate snow fall';
      case 75:
        return 'Heavy snow fall';
      case 77:
        return 'Snow grains';
      case 80:
        return 'Slight rain showers';
      case 81:
        return 'Moderate rain showers';
      case 82:
        return 'Violent rain showers';
      case 85:
        return 'Slight snow showers';
      case 86:
        return 'Heavy snow showers';
      case 95:
        return 'Thunderstorm';
      case 96:
        return 'Thunderstorm with slight hail';
      case 99:
        return 'Thunderstorm with heavy hail';
      default:
        return 'NA';
    }
  }

  static String getWindLabel(int direction) {
    if (direction >= 23 && direction < 68) {
      return 'NE';
    } else if (direction >= 68 && direction < 113) {
      return 'E';
    } else if (direction >= 113 && direction < 158) {
      return 'SE';
    } else if (direction >= 159 && direction < 203) {
      return 'S';
    } else if (direction >= 203 && direction < 248) {
      return 'SW';
    } else if (direction >= 248 && direction < 293) {
      return 'W';
    } else if (direction >= 293 && direction < 338) {
      return 'NW';
    } else if (direction >= 338 && direction < 23) {
      return 'N';
    } else {
      return 'NA';
    }
  }
}