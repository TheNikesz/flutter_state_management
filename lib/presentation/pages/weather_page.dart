import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_bloc/constants/app_colors.dart';
import 'package:weather_app_bloc/data/repositories/weather_repository.dart';
import 'package:weather_app_bloc/presentation/cubits/weather_cubit.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherPage extends StatelessWidget {
  final _citySearchController = TextEditingController(text: 'Warsaw');

  WeatherPage({super.key});

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
            resizeToAvoidBottomInset: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is WeatherSuccess) ...[
                  const Spacer(),
                  _buildCitySearch(),
                  const Spacer(),
                  _buildCityAndDate(),
                  const Spacer(),
                  _buildMainWeather(),
                  const Spacer(),
                  // _buildDailyWeather(),
                  _buildWeeklyWeather(),
                  const Spacer(),
                ] else const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCitySearch() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: _citySearchController,
                textAlign: TextAlign.left,
                cursorColor: AppColors.dayText,
                decoration: InputDecoration(
                  hintText: 'Enter a city name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _citySearchController.clear,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  hoverColor: Colors.transparent,
                  contentPadding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    borderSide:
                        BorderSide(color: AppColors.dayDarkGray, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    borderSide:
                        BorderSide(color: AppColors.dayLightGray, width: 2.0),
                  ),
                ),
                // onSubmitted: (value) => null
              ),
            ),
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              return InkWell(
                hoverColor: Colors.transparent,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.dayLightGray,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Icon(Icons.search)),
                ),
                onTap: () {
                  final weatherCubit = BlocProvider.of<WeatherCubit>(context);
                  weatherCubit.getWeeklyForecast(_citySearchController.text);
                  // final snackBar = SnackBar(content: Text(state.toString()));
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildCityAndDate() {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              if (state is WeatherSuccess) ...[
                Text(toBeginningOfSentenceCase(_citySearchController.text)!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40)),
                Text(DateFormat('EEE dd/MM/yy')
                    .format(DateTime.parse(state.weeklyWeather.first.date))),
              ]
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainWeather() {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
                if (state is WeatherSuccess) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BoxedIcon(
                      getWeatherIcon(state.weeklyWeather.first.weatherCode.toInt()),
                      size: 80.0,
                    ),
                  ),
                  Text(getWeatherLabel(state.weeklyWeather.first.weatherCode.toInt()),
                      style: const TextStyle(fontSize: 15)),
                ],
              ]),
              const SizedBox(
                height: 150,
                child: VerticalDivider(
                  color: AppColors.dayDarkGray,
                  thickness: 2,
                ),
              ),
              if (state is WeatherSuccess)
                Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: Text(
                      '${state.weeklyWeather.first.maxTemperature.toStringAsPrecision(2)}°',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 90)),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDailyWeather(int index) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
          child: SizedBox(
            height: 60,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.dayLightGray,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Stack(
                  children: [
                    if (state is WeatherSuccess) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(DateFormat('EEEE').format(DateTime.parse(
                            state.weeklyWeather.elementAt(index).date))),
                      ),
                      Center(
                        child: BoxedIcon(
                          getWeatherIcon(
                              state.weeklyWeather.elementAt(index).weatherCode.toInt()
                            ),
                          size: 20.0,
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                              '${state.weeklyWeather.elementAt(index).maxTemperature.toStringAsPrecision(2)}°'))
                    ]
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeeklyWeather() {
    List<Widget> dailyWeatherWidgets = [];
    for (var i = 1; i < 7; i++) {
      dailyWeatherWidgets.add(
        _buildDailyWeather(i),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dailyWeatherWidgets,
    );
  }

  IconData getWeatherIcon(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return WeatherIcons.day_sunny;
      case 1:
      case 2:
      case 3:
        return WeatherIcons.day_cloudy;
      case 45:
      case 48:
        return WeatherIcons.day_fog;
      case 51:
      case 53:
      case 55:
      case 80:
      case 81:
      case 82:
        return WeatherIcons.day_showers;
      case 56:
      case 57:
        return WeatherIcons.day_rain_mix;
      case 61:
      case 63:
      case 65:
        return WeatherIcons.day_rain;
      case 66:
      case 67:
        return WeatherIcons.day_sleet;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherIcons.day_snow;
      case 95:
        return WeatherIcons.day_thunderstorm;
      case 96:
      case 99:
        return WeatherIcons.day_snow_thunderstorm;
      default:
        return WeatherIcons.na;
    }
  }

  String getWeatherLabel(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
        return 'Partly cloudy';
      case 2:
        return 'Mainly clear';
      case 3:
        return 'Overcast';
      case 45:
        return 'Fog';
      case 48:
        return 'Depositing rime fog';
      case 51:
        return 'Light drizzle';
      case 53:
        return 'Moderate drizzle';
      case 55:
        return 'Dense drizzle';
      case 56:
        return 'Light freezing drizzle';
      case 57:
        return 'Dense freezing drizzle';
      case 61:
        return 'Slight rain';
      case 63:
        return 'Moderate rain';
      case 65:
        return 'Heavy rain';
      case 66:
        return 'Light freezing rain';
      case 67:
        return 'Heavy freezing rain';
      case 71:
        return 'Slight snow fall';
      case 73:
        return 'Moderate snow fall';
      case 75:
        return 'Heavy snow fall';
      case 77:
        return 'Snow grains';
      case 80:
        return 'Slight rain showers';
      case 81:
        return 'Moderate rain showers';
      case 82:
        return 'Violent rain showers';
      case 85:
        return 'Slight snow showers';
      case 86:
        return 'Heavy snow showers';
      case 95:
        return 'Thunderstorm';
      case 96:
        return 'Thunderstorm with slight hail';
      case 99:
        return 'Thunderstorm with heavy hail';
      default:
        return 'NA';
    }
  }

  // Widget _buildDayNightSwitch() {
  //   return SwitchListTile(value: value, onChanged: onChanged)
  // }
}
