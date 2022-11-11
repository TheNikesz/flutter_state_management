import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => WeatherCubit(
        weatherRepository: context.read<WeatherRepository>(),
      ),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            final weatherCubit = BlocProvider.of<WeatherCubit>(context);
            weatherCubit.getWeeklyForecast('Warsaw');
          }

          return Scaffold(
            backgroundColor: state is WeatherSuccess && state.isNight == true ? AppColors.nightDarkBlue : Colors.white,
            resizeToAvoidBottomInset: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is WeatherSuccess) ...[
                  const Spacer(),
                  const Spacer(),
                  CitySearch(isNight: state.isNight),
                  const Spacer(),
                  CityAndDate(weather: state.weeklyWeather.first, isNight: state.isNight),
                  const Spacer(),
                  MainWeather(weather: state.weeklyWeather.first, isNight: state.isNight),
                  const Spacer(),
                  _buildSwitches(state.isChart, state.isNight),
                  const Spacer(),
                  if (state.isChart == true) ...[
                    WeatherChart(weeklyWeather: state.weeklyWeather, isNight: state.isNight),
                  ] else _buildWeeklyWeather(state.weeklyWeather, state.isNight),
                  const Spacer(),
                ] else if (state is WeatherFailure) ...[
                  const Spacer(),
                  _buildError(state),
                  const Spacer(),
                ] else const Center(child: CircularProgressIndicator()),
              ],
            ),
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
          ChartSwitch(isNight: isNight, isGraph: isChart),
          WeatherSwitch(isNight: isNight)
        ],
      ),
    );
  }

  Widget _buildWeeklyWeather(List<Weather> weeklyWeather, bool isNight) {
    List<Widget> dailyWeatherWidgets = [];

    for (var weather in weeklyWeather) {
      dailyWeatherWidgets.add(DailyWeather(weather: weather, isNight: isNight));
    }
    dailyWeatherWidgets.removeAt(0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dailyWeatherWidgets,
    );
  }

  Widget _buildError(WeatherFailure state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Icon(
            Icons.fmd_bad_outlined,
            size: 50.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 2.0, left: 40.0, right: 40.0),
          child: Text(
            state.errorMessage,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'Please enter a new city name and try again.',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: CitySearch(isNight: false),
        ),
      ],
    );
  }
}