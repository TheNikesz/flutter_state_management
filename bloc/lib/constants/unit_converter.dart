import 'package:intl/intl.dart';

class UnitConverter {
  static int getTemperature(double celsiusTemperature, bool isFahrenheit) {
    if (isFahrenheit) {
      return (celsiusTemperature * 1.8 + 32).round().toInt();
    } else {
      return (celsiusTemperature).round().toInt();
    }
  }

  static String getTemperatureLabel(double celsiusTemperature, bool isFahrenheit) {
    if (isFahrenheit) {
      return '${(celsiusTemperature * 1.8 + 32).round().toInt()}°F';
    } else {
      return '${(celsiusTemperature).round().toInt()}°C';
    }
  }

  static String getHourLabel(String hour, bool is12HourClock) {
    if (is12HourClock) {
      return DateFormat("h:mm a").format(DateFormat('hh:mm').parse(hour));
    } else {
      return hour;
    }
  }

  static String getPrecipitationLabel(double metricPrecipitation, bool isImperial) {
    if (isImperial) {
      return '${(metricPrecipitation / 25.4).round().toInt()} in';
    } else {
      return '${(metricPrecipitation).round().toInt()} mm';
    }
  }

  static String getMaximumWindSpeedLabel(double metricMaximumWindSpeed, bool isImperial) {
    if (isImperial) {
      return '${(metricMaximumWindSpeed / 1.6).round().toInt()} mph';
    } else {
      return '${(metricMaximumWindSpeed).round().toInt()} km/h';
    }
  }
}