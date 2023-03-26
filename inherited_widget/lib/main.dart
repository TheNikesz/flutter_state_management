import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_inherited_widget/presentation/inherited_widgets/shared_preferences_inherited_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/chart_switch_state_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/context/shared_preferences_context.dart';
import 'package:weather_app_inherited_widget/presentation/state/settings_state_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/shared_preferences_state_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/weather_state_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/weather_switch_state_widget.dart';

import 'presentation/pages/weather_page.dart';

void main() {
  runApp(const SharedPreferencesStateWidget(child: WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferencesContext sharedPreferencesContext =
        SharedPreferencesInheritedWidget.of(context);

    if (!sharedPreferencesContext.isLoading) {
      return WeatherStateWidget(
        favouriteCity: sharedPreferencesContext.favouriteCity,
        child: SettingsStateWidget(
          isFarenheit: sharedPreferencesContext.isFahrenheit,
          isChart: sharedPreferencesContext.isChart,
          isNight: sharedPreferencesContext.isNight,
          child: ChartSwitchStateWidget(
            isChart: sharedPreferencesContext.isChart,
            child: WeatherSwitchStateWidget(
              isNight: sharedPreferencesContext.isNight,
              child: MaterialApp(
                  title: 'Weather App (Inherited Widget)',
                  theme: ThemeData(
                    textTheme: GoogleFonts.montserratTextTheme(),
                    scaffoldBackgroundColor: Colors.white,
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(primary: Colors.black),
                  ),
                  home: const WeatherPage()),
            ),
          ),
        ),
      );
    }
    return const CircularProgressIndicator();
  }
}
