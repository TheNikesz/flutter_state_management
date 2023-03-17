import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_bloc/data/data_sources/api.dart';

import '../../constants/app_colors.dart';
import '../controllers/providers.dart';
import '../widgets/chart_switch.dart';
import '../widgets/city_and_date.dart';
import '../widgets/city_search.dart';
import '../widgets/daily_weather.dart';
import '../widgets/main_weather.dart';
import '../widgets/weather_chart.dart';
import '../widgets/weather_switch.dart';

class WeatherPage extends ConsumerWidget {
  final bool isFahrenheitSettings;
  final bool isChartSettings;
  final bool isNightSettings;
  final String favouriteCity;

  const WeatherPage({
    Key? key,
    required this.isFahrenheitSettings,
    required this.isChartSettings,
    required this.isNightSettings,
    required this.favouriteCity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(cityProvider);
    final weeklyWeather = ref.watch(weatherProvider(city));
    final isNight = ref.watch(weatherSwitchProvider);
    final isChart = ref.watch(chartSwitchProvider);

    final settings = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: isNight == true
          ? AppColors.nightDarkBlue
          : Colors.white,
      resizeToAvoidBottomInset: false,
      body: weeklyWeather.when(
        data: (weeklyWeather) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CitySearch(isNight: isNight),
              const Spacer(),
              CityAndDate(
                  weather: weeklyWeather.first,
                  isNight: isNight),
              const Spacer(),
              MainWeather(
                weather: weeklyWeather.first,
                isNight: isNight,
                isFahrenheit: settings.isFahrenheit,
              ),
              const Spacer(),
              _buildSwitches(isChart, isNight),
              const Spacer(),
              if (isChart == true) ...[
                WeatherChart(
                  weeklyWeather: weeklyWeather,
                  isNight: isNight,
                  isFahrenheit: settings.isFahrenheit,
                ),
               ] else SizedBox(
                  height: 410,
                  child: ListView.builder(
                    itemCount: weeklyWeather.skip(1).length,
                    itemBuilder:
                      (BuildContext context, int index) {
                        return DailyWeather(
                            weather: weeklyWeather.skip(1).elementAt(index),
                            isNight: isNight,
                            isFahrenheit: settings.isFahrenheit
                        );
                      },
                  ),
                ),
              const Spacer(),
            ],
          );
        },
        error: (error, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildError(
                (error is GeocodingException) ? 'Error! Couldn\'t fetch the location of that city.' : 'Error! Couldn\'t fetch the weather for that city.',
                isNight
              ),
            const Spacer(),
            ],
          );
        },
        loading: (() => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              isNight ? AppColors.nightText : AppColors.dayText,
            )
          )
        )),
      )
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

  Widget _buildError(String errorMessage, bool isNight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            height: 150,
            child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isNight
                      ? AppColors.nightLightBlue
                      : AppColors.dayLightGray,
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
                            color: isNight
                                ? AppColors.nightText
                                : AppColors.dayText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 2.0, left: 40.0, right: 40.0),
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              fontSize: 15,
                              color: isNight
                                  ? AppColors.nightText
                                  : AppColors.dayText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(
                            'Please enter a new city name and try again.',
                            style: TextStyle(
                              fontSize: 15,
                              color: isNight
                                  ? AppColors.nightText
                                  : AppColors.dayText,
                            ),
                          ),
                        ),
                      ],
                    )))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: CitySearch(isNight: isNight),
        ),
      ],
    );
  }
}
