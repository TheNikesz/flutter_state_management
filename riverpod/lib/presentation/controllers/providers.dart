import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/weather_repository.dart';
import '../../domain/models/weather.dart';
import 'states/switch_state.dart';

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

final switchProvider = StateProvider<SwitchState>((ref) {
  return const SwitchState(isNight: false, isChart: false);
});