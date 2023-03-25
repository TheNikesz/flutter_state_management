import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_inherited_widget/presentation/inherited_widgets/settings_inherited_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/context/settings_context.dart';

class SettingsStateWidget extends StatefulWidget {
  const SettingsStateWidget(
      {Key? key,
      required this.child,
      required this.isFarenheit,
      required this.isChart,
      required this.isNight})
      : super(key: key);

  final Widget child;
  final bool isFarenheit;
  final bool isChart;
  final bool isNight;

  static SettingsStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<SettingsStateWidgetState>()!;
  }

  @override
  State<SettingsStateWidget> createState() => SettingsStateWidgetState();
}

class SettingsStateWidgetState extends State<SettingsStateWidget> {
  SettingsContext _settingsContext =
      SettingsContext(isFahrenheit: false, isChart: false, isNight: false);

  @override
  void initState() {
    super.initState();
    setState(() {
      _settingsContext = SettingsContext(
          isFahrenheit: widget.isFarenheit,
          isChart: widget.isChart,
          isNight: widget.isNight);
    });
  }

  Future<void> changeSettingsTemperatureScaleSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isFahrenheit', value);

    setState(() {
      _settingsContext = _settingsContext.copyWith(
        isFahrenheit: value,
      );
    });
  }

  Future<void> changeSettingsChartSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isChart', value);

    setState(() {
      _settingsContext = _settingsContext.copyWith(
        isChart: value,
      );
    });
  }

  Future<void> changeSettingsWeatherSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isNight', value);

    setState(() {
      _settingsContext = _settingsContext.copyWith(
        isNight: value,
      );
    });
  }

  Future<void> changeSettingsFavouriteCity(String city) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setString('favouriteCity', city);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsInheritedWidget(_settingsContext, child: widget.child);
  }
}
