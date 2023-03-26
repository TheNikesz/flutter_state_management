import 'package:flutter_triple/flutter_triple.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_state.dart';

class SettingsStore extends Store<SettingsState> {
  SettingsStore(super.initialState);

  Future<void> changeSettingsTemperatureScaleSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isFahrenheit', value);

    update(state.copyWith(
      isFahrenheit: value,
    ));
  }

  Future<void> changeSettingsChartSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isChart', value);

    update(state.copyWith(
      isChart: value,
    ));
  }

  Future<void> changeSettingsWeatherSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isNight', value);

    update(state.copyWith(
      isNight: value,
    ));
  }

  Future<void> changeSettingsFavouriteCity(String city) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setString('favouriteCity', city);
  }
}
