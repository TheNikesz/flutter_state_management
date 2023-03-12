import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_state.dart';

class SharedPreferencesCubit extends Cubit<SharedPreferencesState> {
  SharedPreferencesCubit() : super(SharedPreferencesInitial());

  Future<void> getSettingsFromSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final bool? isFahrenheit = sharedPreferences.getBool('isFahrenheit');
    final bool? isChart = sharedPreferences.getBool('isChart');
    final bool? isNight = sharedPreferences.getBool('isNight');
    final String? favouriteCity = sharedPreferences.getString('favouriteCity');

    emit(SharedPreferencesSuccess(
      isFahrenheit: isFahrenheit ?? false,
      isChart: isChart ?? false,
      isNight: isNight ?? false,
      favouriteCity: favouriteCity ?? 'Warsaw',
    ));
  }
}
