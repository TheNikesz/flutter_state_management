import 'package:flutter/material.dart';

import '../state/context/weather_context.dart';

class WeatherInheritedWidget extends InheritedWidget {
  const WeatherInheritedWidget(this.weather, {Key? key, required Widget child})
      : super(key: key, child: child);

  final WeatherContext weather;

  static WeatherContext of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WeatherInheritedWidget>()!
        .weather;
  }

  @override
  bool updateShouldNotify(WeatherInheritedWidget oldWidget) {
    return weather != oldWidget.weather;
  }
}
