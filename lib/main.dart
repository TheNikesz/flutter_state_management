import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_bloc/data/data_sources/api.dart';
import 'package:weather_app_bloc/data/repositories/weather_repository.dart';
import 'package:weather_app_bloc/presentation/pages/weather_page.dart';

import 'domain/models/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
      ),
      home: const WeatherPage(),
    );
  }
}
