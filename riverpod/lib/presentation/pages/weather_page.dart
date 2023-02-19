import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_bloc/data/data_sources/api.dart';

import '../../constants/app_colors.dart';
import '../../domain/models/weather.dart' hide DailyWeather;
import '../controllers/providers.dart';
import '../widgets/chart_switch.dart';
import '../widgets/city_and_date.dart';
import '../widgets/city_search.dart';
import '../widgets/daily_weather.dart';
import '../widgets/main_weather.dart';
import '../widgets/weather_chart.dart';
import '../widgets/weather_switch.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(cityProvider);
    final weeklyWeather = ref.watch(weatherProvider(city));
    // final weeklyWeather = ref.watch(weatherProvider('Warsaw'));
    final isNight = ref.watch(switchProvider).isNight;
    final isChart = ref.watch(switchProvider).isChart;

    return Scaffold(
      backgroundColor: isNight == true ? AppColors.nightDarkBlue : Colors.white,
      resizeToAvoidBottomInset: false,
      body: weeklyWeather.when(
        data: (weeklyWeather) => WeatherSuccess(weeklyWeather: weeklyWeather, isNight: isNight, isChart: isChart,),
        error: (error, __) => (error is GeocodingException) ? const WeatherFailure(errorMessage: 'Error! Couldn\'t fetch the location of that city.') : const WeatherFailure(errorMessage: 'Error! Couldn\'t fetch the weather for that city.'),
        loading: (() => const Center(child: CircularProgressIndicator())),
      )
    );
  }
}

class WeatherSuccess extends StatelessWidget {
  final List<Weather> weeklyWeather;
  final bool isNight;
  final bool isChart;

  const WeatherSuccess({super.key, required this.weeklyWeather, required this.isNight, required this.isChart});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 4,),
        CitySearch(isNight: isNight),
        const Spacer(),
        CityAndDate(weather: weeklyWeather.first, isNight: isNight),
        const Spacer(),
        MainWeather(weather: weeklyWeather.first, isNight: isNight),
        const Spacer(),
        _buildSwitches(isChart, isNight),
        const Spacer(),
        if (isChart == true) ...[
          WeatherChart(weeklyWeather: weeklyWeather, isNight: isNight),
        ] else _buildWeeklyWeather(weeklyWeather, isNight),
        const Spacer(),
      ]
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
}

class WeatherFailure extends StatelessWidget {
  final String errorMessage;

  const WeatherFailure({super.key, required this.errorMessage});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
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
            errorMessage,
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
        const Spacer(),
      ],
    );
  }
}