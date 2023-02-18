// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:weather_app_triple/domain/models/weather.dart';

class WeatherSuccess {
  final List<Weather> weeklyWeather;
  late bool isChart;
  late bool isNight;

  WeatherSuccess(
      {required this.weeklyWeather,
      this.isNight = false,
      this.isChart = false});

  WeatherSuccess copyWith({
    List<Weather>? weeklyWeather,
    bool? isChart,
    bool? isNight,
  }) {
    return WeatherSuccess(
      weeklyWeather: weeklyWeather ?? this.weeklyWeather,
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
    );
  }

  @override
  bool operator ==(covariant WeatherSuccess other) {
    if (identical(this, other)) return true;

    return listEquals(other.weeklyWeather, weeklyWeather) &&
        other.isChart == isChart &&
        other.isNight == isNight;
  }

  @override
  int get hashCode =>
      weeklyWeather.hashCode ^ isChart.hashCode ^ isNight.hashCode;
}
