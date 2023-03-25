import 'package:flutter/material.dart';
import 'package:weather_app_inherited_widget/presentation/inherited_widgets/weather_switch_inherited_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/context/weather_switch_context.dart';

class WeatherSwitchStateWidget extends StatefulWidget {
  const WeatherSwitchStateWidget(
      {Key? key, required this.child, required this.isNight})
      : super(key: key);

  final Widget child;
  final bool isNight;

  static WeatherSwitchStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<WeatherSwitchStateWidgetState>()!;
  }

  @override
  State<WeatherSwitchStateWidget> createState() =>
      WeatherSwitchStateWidgetState();
}

class WeatherSwitchStateWidgetState extends State<WeatherSwitchStateWidget> {
  WeatherSwitchContext _weatherSwitchContext =
      WeatherSwitchContext(isNight: false);

  @override
  void initState() {
    super.initState();
    setState(() {
      _weatherSwitchContext = WeatherSwitchContext(isNight: widget.isNight);
    });
  }

  void changeWeatherSwitchValue(bool value) {
    setState(() {
      _weatherSwitchContext = _weatherSwitchContext.copyWith(isNight: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WeatherSwitchInheritedWidget(_weatherSwitchContext,
        child: widget.child);
  }
}
