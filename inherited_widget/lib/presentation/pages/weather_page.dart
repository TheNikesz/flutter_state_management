import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../domain/models/weather.dart' hide DailyWeather;
import '../inherited_widgets/weather_inherited_widget.dart';
import '../state/weather_state_widget.dart';
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
    final weatherState = WeatherInheritedWidget.of(context);

    return Scaffold(
      backgroundColor:
          weatherState.isNight == true ? AppColors.nightDarkBlue : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (weatherState.errorMessage != null) ...[
            const Spacer(),
            _buildError(weatherState.errorMessage!),
            const Spacer(),
          ] else if (!weatherState.isLoading &&
              weatherState.weeklyWeather != null) ...[
            const Spacer(
              flex: 4,
            ),
            CitySearch(isNight: weatherState.isNight),
            const Spacer(),
            CityAndDate(
                weather: weatherState.weeklyWeather!.first,
                isNight: weatherState.isNight),
            const Spacer(),
            MainWeather(
                weather: weatherState.weeklyWeather!.first,
                isNight: weatherState.isNight),
            const Spacer(),
            _buildSwitches(weatherState.isChart, weatherState.isNight),
            const Spacer(),
            if (weatherState.isChart == true) ...[
              WeatherChart(
                  weeklyWeather: weatherState.weeklyWeather!,
                  isNight: weatherState.isNight),
            ] else
              _buildWeeklyWeather(
                  weatherState.weeklyWeather!, weatherState.isNight),
            const Spacer(),
          ] else
            const Center(child: CircularProgressIndicator()),
        ],
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

  Widget _buildError(String errorMessage) {
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
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 2.0, left: 40.0, right: 40.0),
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
      ],
    );
  }
}
