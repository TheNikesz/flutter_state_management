import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(isFahrenheit: false));

  void changeTemperatureScaleSwitchValue(bool value) {
    emit(state.copyWith(
      isFahrenheit: value,
    ));
  }
}
