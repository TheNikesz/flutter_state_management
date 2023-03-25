import 'package:flutter_triple/flutter_triple.dart';

class WeatherSwitchStore extends Store<bool> {
  WeatherSwitchStore(super.initialState);

  void changeWeatherSwitchValue(bool value) {
    update(value);
  }
}
