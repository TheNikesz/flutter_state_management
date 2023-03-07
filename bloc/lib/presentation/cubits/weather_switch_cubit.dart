import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_switch_state.dart';

class WeatherSwitchCubit extends Cubit<WeatherSwitchState> {
  WeatherSwitchCubit() : super(const WeatherSwitchState(isNight: false));

  void changeWeatherSwitchValue(bool value) {
    emit(state.copyWith(
      isNight: value,
    ));
  }
}