// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import '../../../domain/models/weather.dart';

class WeatherContext {
  final List<Weather>? weeklyWeather;
  final bool isLoading;
  final String? errorMessage;

  WeatherContext({
    this.weeklyWeather,
    required this.isLoading,
    this.errorMessage,
  });

  WeatherContext copyWith({
    List<Weather>? weeklyWeather,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WeatherContext(
      weeklyWeather: weeklyWeather ?? this.weeklyWeather,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(covariant WeatherContext other) {
    if (identical(this, other)) return true;

    return listEquals(other.weeklyWeather, weeklyWeather) &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      weeklyWeather.hashCode ^ isLoading.hashCode ^ errorMessage.hashCode;
}
