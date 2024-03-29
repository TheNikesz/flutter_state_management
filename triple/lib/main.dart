import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_triple/data/data_sources/api.dart';
import 'package:weather_app_triple/data/repositories/weather_repository.dart';
import 'package:weather_app_triple/presentation/pages/weather_page.dart';
import 'package:weather_app_triple/presentation/triple/chart_switch_store.dart';
import 'package:weather_app_triple/presentation/triple/settings_state.dart';
import 'package:weather_app_triple/presentation/triple/settings_store.dart';
import 'package:weather_app_triple/presentation/triple/shared_preferences_store.dart';
import 'package:weather_app_triple/presentation/triple/weather_store.dart';
import 'package:weather_app_triple/presentation/triple/weather_switch_store.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // print("pid: $pid");
  // //execute code every 1s
  // Timer.periodic(const Duration(milliseconds: 250), (timer) {
  //   //print ram usage
  //   print("ram: ${ProcessInfo.currentRss / 1024 / 1024} MB");
  // });
  late SharedPreferencesStore sharedPreferencesStore;

  getIt.registerSingletonAsync<SharedPreferencesStore>(() async {
    sharedPreferencesStore = SharedPreferencesStore();
    await sharedPreferencesStore.getSettingsFromSharedPreferences();

    getIt.registerSingleton(
        ChartSwitchStore(sharedPreferencesStore.state.isChart));
    getIt.registerSingleton(
        WeatherSwitchStore(sharedPreferencesStore.state.isNight));
    getIt.registerSingleton(SettingsStore(SettingsState(
        isChart: sharedPreferencesStore.state.isChart,
        isFahrenheit: sharedPreferencesStore.state.isFahrenheit,
        isNight: sharedPreferencesStore.state.isNight)));

    return sharedPreferencesStore;
  });

  getIt.registerSingletonAsync<WeatherStore>(() async {
    final weatherStore = WeatherStore(
        weatherRepository: WeatherRepository(
            geocodingApi: OpenMeteoGeocodingApi(),
            weatherForecastApi: OpenMeteoWeatherForecastApi()));
    await weatherStore
        .getWeeklyForecast(sharedPreferencesStore.state.favouriteCity);
    return weatherStore;
  }, dependsOn: [SharedPreferencesStore]);

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App (Triple)',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.black),
      ),
      home: const WeatherPage(),
    );
  }
}