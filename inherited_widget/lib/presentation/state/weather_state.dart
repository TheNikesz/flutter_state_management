import 'package:flutter/foundation.dart';

import '../../domain/models/weather.dart';

class WeatherState {
  List<Weather>? weeklyWeather;
  bool isLoading;
  bool isChart;
  bool isNight;
  String? errorMessage;

  WeatherState({
    this.weeklyWeather,
    this.isLoading = true,
    this.isChart = false,
    this.isNight = false,
    this.errorMessage,
  });

  WeatherState copyWith({
    List<Weather>? weeklyWeather,
    bool? isLoading,
    bool? isChart,
    bool? isNight,
    String? errorMessage,
  }) {
    return WeatherState(
      weeklyWeather: weeklyWeather ?? this.weeklyWeather,
      isLoading: isLoading ?? this.isLoading,
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'WeatherState(weeklyWeather: $weeklyWeather, isLoading: $isLoading, isChart: $isChart, isNight: $isNight, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(covariant WeatherState other) {
    if (identical(this, other)) return true;

    return listEquals(other.weeklyWeather, weeklyWeather) &&
        other.isLoading == isLoading &&
        other.isChart == isChart &&
        other.isNight == isNight &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return weeklyWeather.hashCode ^
        isLoading.hashCode ^
        isChart.hashCode ^
        isNight.hashCode ^
        errorMessage.hashCode;
  }
}
