import 'package:flutter_triple/flutter_triple.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_state.dart';

class SharedPreferencesStore extends Store<SharedPreferencesState> {
  SharedPreferencesStore() : super(SharedPreferencesState());

  Future<void> getSettingsFromSharedPreferences() async {
    setLoading(true);

    final sharedPreferences = await SharedPreferences.getInstance();
    final bool? isFahrenheit = sharedPreferences.getBool('isFahrenheit');
    final bool? isChart = sharedPreferences.getBool('isChart');
    final bool? isNight = sharedPreferences.getBool('isNight');
    final String? favouriteCity = sharedPreferences.getString('favouriteCity');

    update(SharedPreferencesState(
      isFahrenheit: isFahrenheit ?? false,
      isChart: isChart ?? false,
      isNight: isNight ?? false,
      favouriteCity: favouriteCity ?? 'Warsaw',
    ));
    setLoading(false);
  }
}
