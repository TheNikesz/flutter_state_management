import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required bool isFahrenheit, required bool isChart, required bool isNight}) : super(SettingsState(isFahrenheit: isFahrenheit, isChart: isChart, isNight: isNight));

  Future<void> changeSettingsTemperatureScaleSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isFahrenheit', value);

    emit(state.copyWith(
      isFahrenheit: value,
    ));
  }

  Future<void> changeSettingsChartSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isChart', value);

    emit(state.copyWith(
      isChart: value,
    ));
  }

  Future<void> changeSettingsWeatherSwitchValue(bool value) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setBool('isNight', value);

    emit(state.copyWith(
      isNight: value,
    ));
  }

  Future<void> changeSettingsFavouriteCity(String city) async {
    SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
    sharedPrefrences.setString('favouriteCity', city);
  }
}
