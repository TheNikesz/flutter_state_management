import 'package:flutter/material.dart';

import '../cubits/weather_cubit.dart';
import '../inherited_widgets/weather_inherited_widget.dart';

class WeatherStateWidget extends StatefulWidget {
  const WeatherStateWidget({super.key, required this.child});

  final Widget child;

  static WeatherStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<WeatherStateWidgetState>()!;
  }

  @override
  State<WeatherStateWidget> createState() => WeatherStateWidgetState();
}

class WeatherStateWidgetState extends State<WeatherStateWidget> {
  WeatherState _weatherState = WeatherState();

  @override
  Widget build(BuildContext context) {
    return WeatherInheritedWidget(_weatherState, child: widget.child);
  }
}
