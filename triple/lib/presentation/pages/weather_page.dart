import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:weather_app_triple/constants/app_colors.dart';
import 'package:weather_app_triple/domain/models/weather.dart'
    hide DailyWeather;
import 'package:weather_app_triple/main.dart';
import 'package:weather_app_triple/presentation/triple/switch_store.dart';
import 'package:weather_app_triple/presentation/triple/weather_store.dart';
import 'package:weather_app_triple/presentation/triple/switch_state.dart';
import 'package:weather_app_triple/presentation/widgets/chart_switch.dart';
import 'package:weather_app_triple/presentation/widgets/city_and_date.dart';
import 'package:weather_app_triple/presentation/widgets/city_search.dart';
import 'package:weather_app_triple/presentation/widgets/daily_weather.dart';
import 'package:weather_app_triple/presentation/widgets/main_weather.dart';
import 'package:weather_app_triple/presentation/widgets/weather_chart.dart';
import 'package:weather_app_triple/presentation/widgets/weather_switch.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key});

  final WeatherStore weatherStore = getIt<WeatherStore>();
  final SwitchStore switchStore = getIt<SwitchStore>();

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<SwitchStore, Exception, SwitchState>(
        store: switchStore,
        onState: (context, switchState) {
          return Scaffold(
            backgroundColor: switchState.isNight == true
                ? AppColors.nightDarkBlue
                : Colors.white,
            resizeToAvoidBottomInset: false,
            body: ScopedBuilder<WeatherStore, Exception, List<Weather>>(
              store: weatherStore,
              onState: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  CitySearch(isNight: switchState.isNight),
                  const Spacer(),
                  CityAndDate(
                      weather: state.first, isNight: switchState.isNight),
                  const Spacer(),
                  MainWeather(
                      weather: state.first, isNight: switchState.isNight),
                  const Spacer(),
                  _buildSwitches(switchState.isChart, switchState.isNight),
                  const Spacer(),
                  if (switchState.isChart == true) ...[
                    WeatherChart(
                        weeklyWeather: state, isNight: switchState.isNight),
                  ] else
                    _buildWeeklyWeather(state, switchState.isNight),
                  const Spacer(),
                ],
              ),
              onError: (context, error) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  _buildError("$error"),
                  const Spacer(),
                ],
              ),
              onLoading: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        });
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

  Widget _buildError(String state) {
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
            state,
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
