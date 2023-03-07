class TemperatureCalculator {
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
}