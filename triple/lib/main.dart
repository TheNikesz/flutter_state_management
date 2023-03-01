import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_triple/presentation/pages/weather_page.dart';
import 'package:weather_app_triple/presentation/triple/switch_store.dart';
import 'package:weather_app_triple/presentation/triple/weather_store.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingletonAsync<WeatherStore>(() async {
    final weatherStore = WeatherStore();
    await weatherStore.getWeeklyForecast('Warsaw');
    return weatherStore;
  });

  getIt.registerSingleton(SwitchStore());

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App (Triple)',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.black),
      ),
      home: FutureBuilder(
          future: getIt.allReady(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WeatherPage();
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
