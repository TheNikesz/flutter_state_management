import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(const SwitchState(isNight: false, isChart: false));

  void changeGraphSwitchValue(bool value) {
    emit(state.copyWith(
      isChart: value,
    ));
  }

  void changeWeatherSwitchValue(bool value) {
    emit(state.copyWith(
      isNight: value,
    ));
  }
}