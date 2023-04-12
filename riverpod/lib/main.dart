import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_riverpod/presentation/controllers/providers.dart';
import 'package:weather_app_riverpod/presentation/pages/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const ProviderScope(child: WeatherApp()));
}

class WeatherApp extends ConsumerWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharedPreferences = ref.watch(sharedPrefenecesProvider);

    return MaterialApp(
      title: 'Weather App (Riverpod)',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: sharedPreferences.when(
        data: (sharedPreferences) {
          Future((() => ref.read(settingsProvider.notifier).state = ref
              .read(settingsProvider.notifier)
              .state
              .copyWith(
                  isFahrenheit: sharedPreferences.isFahrenheit,
                  isNight: sharedPreferences.isNight,
                  isChart: sharedPreferences.isChart)));
          Future((() => ref.read(weatherSwitchProvider.notifier).state =
              sharedPreferences.isNight));
          Future((() => ref.read(chartSwitchProvider.notifier).state =
              sharedPreferences.isChart));
          Future((() => ref.read(cityProvider.notifier).state =
              sharedPreferences.favouriteCity));

          return const WeatherPage();
        },
        error: (error, __) => null,
        loading: (() => const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
