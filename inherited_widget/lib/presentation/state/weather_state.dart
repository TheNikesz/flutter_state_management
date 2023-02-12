// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:weather_app_bloc/domain/models/weather.dart';

class WeatherState {
  List<Weather>? weeklyWeather;
  bool isLoading;
  bool isChart;
  bool isNight;

  WeatherState({
    this.weeklyWeather,
    this.isLoading = true,
    this.isChart = false,
    this.isNight = false,
  });

  WeatherState copyWith({
    List<Weather>? weeklyWeather,
    bool? isLoading,
    bool? isChart,
    bool? isNight,
  }) {
    return WeatherState(
      weeklyWeather: weeklyWeather ?? this.weeklyWeather,
      isLoading: isLoading ?? this.isLoading,
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
    );
  }

  @override
  String toString() {
    return 'WeatherState(weeklyWeather: $weeklyWeather, isLoading: $isLoading, isChart: $isChart, isNight: $isNight)';
  }

  @override
  bool operator ==(covariant WeatherState other) {
    if (identical(this, other)) return true;

    return listEquals(other.weeklyWeather, weeklyWeather) &&
        other.isLoading == isLoading &&
        other.isChart == isChart &&
        other.isNight == isNight;
  }

  @override
  int get hashCode {
    return weeklyWeather.hashCode ^
        isLoading.hashCode ^
        isChart.hashCode ^
        isNight.hashCode;
  }
}
