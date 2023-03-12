import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_switch_state.dart';

class WeatherSwitchCubit extends Cubit<WeatherSwitchState> {
  WeatherSwitchCubit({required bool isNight}) : super(WeatherSwitchState(isNight: isNight));

  Future<void> changeWeatherSwitchValue(bool value) async {
    emit(state.copyWith(
      isNight: value,
    ));
  }
}