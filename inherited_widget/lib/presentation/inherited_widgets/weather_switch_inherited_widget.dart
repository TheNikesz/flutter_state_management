import 'package:flutter/material.dart';

import '../state/context/weather_switch_context.dart';

class WeatherSwitchInheritedWidget extends InheritedWidget {
  const WeatherSwitchInheritedWidget(this.weatherSwitchContext,
      {Key? key, required Widget child})
      : super(key: key, child: child);

  final WeatherSwitchContext weatherSwitchContext;

  static WeatherSwitchContext of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WeatherSwitchInheritedWidget>()!
        .weatherSwitchContext;
  }

  @override
  bool updateShouldNotify(WeatherSwitchInheritedWidget oldWidget) {
    return weatherSwitchContext != oldWidget.weatherSwitchContext;
  }
}
