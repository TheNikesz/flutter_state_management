import 'package:flutter/material.dart';

import '../../domain/models/weather.dart';

class WeatherInheritedWidget extends InheritedWidget {
  const WeatherInheritedWidget(this.weather, {Key? key, required Widget child})
      : super(key: key, child: child);

  final Weather weather;

  static Weather of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WeatherInheritedWidget>()!
        .weather;
  }

  @override
  bool updateShouldNotify(WeatherInheritedWidget oldWidget) {
    return weather != oldWidget.weather;
  }
}
