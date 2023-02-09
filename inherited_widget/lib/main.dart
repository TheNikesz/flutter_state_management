import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_bloc/presentation/pages/weather_page.dart';

import 'data/repositories/weather_repository.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(),
      child: MaterialApp(
        title: 'Weather App (Inherited Widget)',
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          scaffoldBackgroundColor: Colors.white, 
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.black),
        ),
        home: const WeatherPage(),
      ),
    );
  }
}