import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/presentation/cubits/chart_switch_cubit.dart';
import 'package:weather_app_bloc/presentation/cubits/settings_cubit.dart';
import 'package:weather_app_bloc/presentation/cubits/weather_switch_cubit.dart';

import '../../constants/app_colors.dart';
import '../../data/repositories/weather_repository.dart';
import '../../domain/models/weather.dart' hide DailyWeather;
import '../cubits/weather_cubit.dart';
import '../widgets/chart_switch.dart';
import '../widgets/city_and_date.dart';
import '../widgets/city_search.dart';
import '../widgets/daily_weather.dart';
import '../widgets/main_weather.dart';
import '../widgets/weather_chart.dart';
import '../widgets/weather_switch.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
                  weatherRepository: context.read<WeatherRepository>(),
                )),
        BlocProvider<WeatherSwitchCubit>(
          create: (context) => WeatherSwitchCubit(),
        ),
        BlocProvider<ChartSwitchCubit>(
          create: (context) => ChartSwitchCubit(),
        ),
      ],
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, weatherState) {
          return BlocBuilder<WeatherSwitchCubit, WeatherSwitchState>(
            builder: (context, weatherSwitchState) {
              if (weatherState is WeatherInitial) {
                final weatherCubit = BlocProvider.of<WeatherCubit>(context);
                weatherCubit.getWeeklyForecast('Warsaw');
              }

              return Scaffold(
                backgroundColor: weatherSwitchState.isNight == true
                    ? AppColors.nightDarkBlue
                    : Colors.white,
                resizeToAvoidBottomInset: false,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (weatherState is WeatherSuccess) ...[
                      const Spacer(),
                      CitySearch(isNight: weatherSwitchState.isNight),
                      const Spacer(),
                      CityAndDate(
                          weather: weatherState.weeklyWeather.first,
                          isNight: weatherSwitchState.isNight),
                      const Spacer(),
                      BlocBuilder<SettingsCubit, SettingsState>(
                        builder: (context, settingsState) {
                          return MainWeather(
                            weather: weatherState.weeklyWeather.first,
                            isNight: weatherSwitchState.isNight,
                            isFahrenheit: settingsState.isFahrenheit,
                          );
                        },
                      ),
                      const Spacer(),
                      BlocBuilder<ChartSwitchCubit, ChartSwitchState>(
                        builder: (context, chartSwitchState) {
                          return _buildSwitches(chartSwitchState.isChart,
                              weatherSwitchState.isNight);
                        },
                      ),
                      const Spacer(),
                      BlocBuilder<ChartSwitchCubit, ChartSwitchState>(
                        builder: (context, chartSwitchState) {
                          if (chartSwitchState.isChart == true) {
                            return BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, settingsState) {
                                return WeatherChart(
                                    weeklyWeather: weatherState.weeklyWeather,
                                    isNight: weatherSwitchState.isNight,
                                    isFahrenheit: settingsState.isFahrenheit,
                                );
                              },
                            );
                          } else {
                            return _buildWeeklyWeather(
                                weatherState.weeklyWeather,
                                weatherSwitchState.isNight);
                          }
                        },
                      ),
                      const Spacer(),
                    ] else if (weatherState is WeatherFailure) ...[
                      const Spacer(),
                      _buildError(weatherState.errorMessage,
                          weatherSwitchState.isNight),
                      const Spacer(),
                    ] else
                      Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                        weatherSwitchState.isNight
                            ? AppColors.nightText
                            : AppColors.dayText,
                      ))),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSwitches(bool isChart, bool isNight) {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ChartSwitch(isNight: isNight, isChart: isChart),
          WeatherSwitch(isNight: isNight)
        ],
      ),
    );
  }

  Widget _buildWeeklyWeather(List<Weather> weeklyWeather, bool isNight) {
    List<Widget> dailyWeatherWidgets = [];

    for (var weather in weeklyWeather) {
      dailyWeatherWidgets.add(BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return DailyWeather(
              weather: weather,
              isNight: isNight,
              isFahrenheit: settingsState.isFahrenheit);
        },
      ));
    }
    dailyWeatherWidgets.removeAt(0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dailyWeatherWidgets,
    );
  }

  Widget _buildError(String errorMessage, bool isNight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Icon(
            Icons.fmd_bad_outlined,
            size: 50.0,
            color: isNight ? AppColors.nightText : AppColors.dayText,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 2.0, left: 40.0, right: 40.0),
          child: Text(
            errorMessage,
            style: TextStyle(
              fontSize: 15,
              color: isNight ? AppColors.nightText : AppColors.dayText,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'Please enter a new city name and try again.',
            style: TextStyle(
              fontSize: 15,
              color: isNight ? AppColors.nightText : AppColors.dayText,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: CitySearch(isNight: isNight),
        ),
      ],
    );
  }
}
