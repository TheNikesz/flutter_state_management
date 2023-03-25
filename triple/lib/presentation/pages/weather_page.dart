import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:weather_app_triple/domain/models/weather.dart'
    hide DailyWeather;
import 'package:weather_app_triple/main.dart';
import 'package:weather_app_triple/presentation/triple/chart_switch_store.dart';
import 'package:weather_app_triple/presentation/triple/settings_state.dart';
import 'package:weather_app_triple/presentation/triple/settings_store.dart';
import 'package:weather_app_triple/presentation/triple/weather_store.dart';

import 'package:weather_app_triple/presentation/triple/weather_switch_store.dart';

import '../../constants/app_colors.dart';
import '../widgets/chart_switch.dart';
import '../widgets/city_and_date.dart';
import '../widgets/city_search.dart';
import '../widgets/daily_weather.dart';
import '../widgets/main_weather.dart';
import '../widgets/weather_chart.dart';
import '../widgets/weather_switch.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chartSwitchStore = getIt<ChartSwitchStore>();

    return ScopedBuilder<WeatherSwitchStore, bool>(
      store: getIt<WeatherSwitchStore>(),
      onState: (context, weatherSwitchState) => Scaffold(
        backgroundColor:
            weatherSwitchState == true ? AppColors.nightDarkBlue : Colors.white,
        resizeToAvoidBottomInset: false,
        body: ScopedBuilder<WeatherStore, List<Weather>>(
          store: getIt<WeatherStore>(),
          onError: (context, error) => Column(
            children: [
              const Spacer(),
              _buildError(error, weatherSwitchState),
              const Spacer(),
            ],
          ),
          onLoading: (context) => _buildLoading(weatherSwitchState),
          onState: (context, weatherState) =>
              ScopedBuilder<SettingsStore, SettingsState>(
            store: getIt<SettingsStore>(),
            onState: (context, settingsState) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                CitySearch(isNight: weatherSwitchState),
                const Spacer(),
                CityAndDate(
                    weather: weatherState.first, isNight: weatherSwitchState),
                const Spacer(),
                MainWeather(
                  weather: weatherState.first,
                  isNight: weatherSwitchState,
                  isFahrenheit: settingsState.isFahrenheit,
                ),
                const Spacer(),
                ScopedBuilder<ChartSwitchStore, bool>(
                  store: chartSwitchStore,
                  onState: (context, chartSwitchState) {
                    return _buildSwitches(chartSwitchState, weatherSwitchState);
                  },
                ),
                const Spacer(),
                ScopedBuilder<ChartSwitchStore, bool>(
                    store: chartSwitchStore,
                    onState: (context, chartSwitchState) {
                      if (chartSwitchState == true) {
                        return WeatherChart(
                          weeklyWeather: weatherState,
                          isNight: weatherSwitchState,
                          isFahrenheit: settingsState.isFahrenheit,
                        );
                      } else {
                        return SizedBox(
                          height: 410,
                          child: ListView.builder(
                            itemCount: weatherState.skip(1).length,
                            itemBuilder: (BuildContext context, int index) {
                              return DailyWeather(
                                  weather:
                                      weatherState.skip(1).elementAt(index),
                                  isNight: weatherSwitchState,
                                  isFahrenheit: settingsState.isFahrenheit);
                            },
                          ),
                        );
                      }
                    }),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitches(bool isChart, bool isNight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChartSwitch(isNight: isNight, isChart: isChart),
        WeatherSwitch(isNight: isNight)
      ],
    );
  }

  Widget _buildLoading(bool isNight) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          isNight ? AppColors.nightText : AppColors.dayText,
        ),
      ),
    );
  }

  Widget _buildError(String errorMessage, bool isNight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color:
                  isNight ? AppColors.nightLightBlue : AppColors.dayLightGray,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 5.0, left: 10.0, right: 10.0),
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
                        color:
                            isNight ? AppColors.nightText : AppColors.dayText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'Please enter a new city name and try again.',
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            isNight ? AppColors.nightText : AppColors.dayText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: CitySearch(isNight: isNight),
        ),
      ],
    );
  }
}
