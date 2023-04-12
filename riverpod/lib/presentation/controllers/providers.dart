import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_riverpod/presentation/controllers/states/shared_preferences_state.dart';

import '../../data/repositories/weather_repository.dart';
import '../../domain/models/weather.dart';
import 'states/settings_state.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

final cityProvider = StateProvider<String>((ref) {
  return 'Warsaw';
});

final weatherProvider = FutureProvider.autoDispose.family<List<Weather>, String>((ref, city) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return weatherRepository.getWeeklyForecast(city);
});

final settingsProvider = StateProvider<SettingsState>((ref) {
  return const SettingsState(isFahrenheit: false, isNight: false, isChart: false);
});

final sharedPrefenecesProvider = FutureProvider.autoDispose<SharedPreferencesState>((ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final bool? isFahrenheit = sharedPreferences.getBool('isFahrenheit');
  final bool? isChart = sharedPreferences.getBool('isChart');
  final bool? isNight = sharedPreferences.getBool('isNight');
  final String? favouriteCity = sharedPreferences.getString('favouriteCity');
  
  return SharedPreferencesState(
    isFahrenheit: isFahrenheit ?? false,
    isChart: isChart ?? false,
    isNight: isNight ?? false,
    favouriteCity: favouriteCity ?? 'Warsaw',
    );
});

final weatherSwitchProvider = StateProvider<bool>((ref) {
  return ref.read(settingsProvider).isNight;
});

final chartSwitchProvider = StateProvider<bool>((ref) {
  return ref.read(settingsProvider).isChart;
});