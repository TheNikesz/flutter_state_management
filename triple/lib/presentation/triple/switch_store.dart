import 'package:flutter_triple/flutter_triple.dart';
import 'package:weather_app_triple/presentation/triple/switch_state.dart';

class SwitchStore extends StreamStore<Exception, SwitchState> {
  SwitchStore() : super(SwitchState());

  void changeGraphSwitchValue(bool value) {
    update(state.copyWith(isChart: value));
  }

  void changeWeatherSwitchValue(bool value) {
    update(state.copyWith(isNight: value));
  }
}
