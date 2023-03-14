import 'package:flutter/material.dart';

import '../state/weather_state.dart';

class WeatherInheritedWidget extends InheritedWidget {
  const WeatherInheritedWidget(this.weather, {Key? key, required Widget child})
      : super(key: key, child: child);

  final WeatherState weather;

  static WeatherState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WeatherInheritedWidget>()!
        .weather;
  }

  @override
  bool updateShouldNotify(WeatherInheritedWidget oldWidget) {
    return weather != oldWidget.weather;
  }
}
