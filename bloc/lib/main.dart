import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_bloc/presentation/cubits/chart_switch_cubit.dart';
import 'package:weather_app_bloc/presentation/cubits/settings_cubit.dart';
import 'package:weather_app_bloc/presentation/cubits/shared_preferences_cubit.dart';
import 'package:weather_app_bloc/presentation/cubits/weather_cubit.dart';
import 'package:weather_app_bloc/presentation/cubits/weather_switch_cubit.dart';
import 'package:weather_app_bloc/presentation/pages/weather_page.dart';

import 'data/repositories/weather_repository.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return BlocProvider(
      create: (context) =>
          SharedPreferencesCubit()..getSettingsFromSharedPreferences(),
      child: BlocBuilder<SharedPreferencesCubit, SharedPreferencesState>(
          builder: (context, sharedPreferencesState) {
            if (sharedPreferencesState is SharedPreferencesSuccess) {
              return RepositoryProvider(
                create: (context) => WeatherRepository(),
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<SettingsCubit>(
                      create: (context) =>
                          SettingsCubit(
                                  isFahrenheit: sharedPreferencesState.isFahrenheit,
                                  isChart: sharedPreferencesState.isChart,
                                  isNight: sharedPreferencesState.isNight),
                    ),
                    BlocProvider<WeatherCubit>(
                        create: (context) => WeatherCubit(
                                weatherRepository: context.read<WeatherRepository>(),
                                favouriteCity: sharedPreferencesState.favouriteCity,
                              )
                    ),
                    BlocProvider<ChartSwitchCubit>(
                      create: (context) => ChartSwitchCubit(isChart: sharedPreferencesState.isChart)
                    ),
                    BlocProvider<WeatherSwitchCubit>(
                      create: (context) => WeatherSwitchCubit(
                                  isNight: sharedPreferencesState.isNight)
                    ),
                  ],
                  child: MaterialApp(
                    title: 'Weather App (Bloc)',
                    theme: ThemeData(
                      textTheme: GoogleFonts.montserratTextTheme(),
                      scaffoldBackgroundColor: Colors.white,
                    ),
                    home: const WeatherPage(),
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }        
      }),
    );
  }
}
