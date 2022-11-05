import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_bloc/constants/app_colors.dart';
import 'package:weather_app_bloc/data/repositories/weather_repository.dart';
import 'package:weather_app_bloc/presentation/cubits/weather_cubit.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../domain/models/weather.dart';

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
            backgroundColor: state is WeatherSuccess && state.isNight == true ? AppColors.nightDarkBlue : Colors.white,
            resizeToAvoidBottomInset: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is WeatherSuccess) ...[
                  const Spacer(),
                  _buildCitySearch(context, state.isNight),
                  const Spacer(),
                  _buildCityAndDate(state.weeklyWeather, state.isNight),
                  const Spacer(),
                  _buildMainWeather(state.weeklyWeather, state.isNight),
                  const Spacer(),
                  _buildWeatherSwitch(context, state.isNight),
                  const Spacer(),
                  // _buildDailyWeather(),
                  _buildWeeklyWeather(state.weeklyWeather, state.isNight),
                  const Spacer(),
                ] else const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCitySearch(BuildContext context, bool isNight) {
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
                style: TextStyle(
                  color: isNight ? AppColors.nightText : AppColors.dayText,
                ),
                textAlign: TextAlign.left,
                cursorColor: isNight ? AppColors.nightText : AppColors.dayText,
                decoration: InputDecoration(
                  hintText: 'Enter a city name',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                    ),
                    onPressed: _citySearchController.clear,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  hoverColor: Colors.transparent,
                  contentPadding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  fillColor: isNight ? AppColors.nightDarkBlue : Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    borderSide:
                        BorderSide(
                          color: isNight ? AppColors.nightLightBlue : AppColors.dayDarkGray,
                          width: 2.0,
                        ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    borderSide:
                        BorderSide(
                          color: isNight ? AppColors.nightLightBlue : AppColors.dayDarkGray,
                          width: 2.0
                        ),
                  ),
                ),
                // onSubmitted: (value) => null
              ),
            ),
          ),
          InkWell(
            hoverColor: Colors.transparent,
            child: Container(
              height: 49,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isNight ? AppColors.nightLightBlue : AppColors.dayLightGray,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  Icons.search,
                  color: isNight ? AppColors.nightText : AppColors.dayText,
                )
              ),
            ),
            onTap: () {
              final weatherCubit = BlocProvider.of<WeatherCubit>(context);
              weatherCubit.getWeeklyForecast(_citySearchController.text);
              // final snackBar = SnackBar(content: Text(state.toString()));
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
    );
  }

  Widget _buildCityAndDate(List<Weather> weeklyWeather, bool isNight) {
    return Center(
      child: Column(
        children: [
          Text(toBeginningOfSentenceCase(_citySearchController.text)!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40,
                  color: isNight ? AppColors.nightText : AppColors.dayText,
              )
            ),
          Text(
            DateFormat('EEE dd/MM/yy').format(DateTime.parse(weeklyWeather.first.date)),
            style: TextStyle(
              color: isNight ? AppColors.nightText : AppColors.dayText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainWeather(List<Weather> weeklyWeather, bool isNight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BoxedIcon(
                    getWeatherIcon(weeklyWeather.first.weatherCode.toInt(), isNight),
                    color: isNight ? Colors.white : Colors.black,
                    size: 80.0,
                  ),
                ),
                Text(
                  getWeatherLabel(weeklyWeather.first.weatherCode.toInt()),
                  style: TextStyle(
                    fontSize: 15,
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  ),
                ),
              ]
            ),
          ),
          Center(
            child: SizedBox(
              height: 150,
              child: VerticalDivider(
                color: isNight ? AppColors.nightLightBlue : AppColors.dayDarkGray,
                thickness: 3,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              isNight ? '${weeklyWeather.first.minTemperature.toStringAsFixed(0)}°' : '${weeklyWeather.first.maxTemperature.toStringAsFixed(0)}°',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 90,
                  color: isNight ? AppColors.nightText : AppColors.dayText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherSwitch(BuildContext context, bool isNight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BoxedIcon(
          WeatherIcons.day_sunny,
          color: isNight ? Colors.white : Colors.black,
        ),
        Switch(
          hoverColor: Colors.transparent,
          activeColor: AppColors.dayDarkGray,
          activeTrackColor: AppColors.dayLightGray,
          inactiveThumbColor: Colors.black,
          inactiveTrackColor: Colors.black87,
          value: isNight,
          onChanged: (value) {
            final weatherCubit = BlocProvider.of<WeatherCubit>(context);
            weatherCubit.changeWeatherSwitchValue(value);
          },
        ),
        BoxedIcon(
          WeatherIcons.night_clear,
          color: isNight ? Colors.white : Colors.black,
        ),
      ],
    );
  }

  Widget _buildDailyWeather(List<Weather> weeklyWeather, bool isNight, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
      child: SizedBox(
        height: 60,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isNight ? AppColors.nightLightBlue : AppColors.dayLightGray,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('EEEE').format(DateTime.parse(weeklyWeather.elementAt(index).date)),
                    style: TextStyle(
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                    ),
                  ),
                ),
                Center(
                  child: BoxedIcon(
                    getWeatherIcon(
                      weeklyWeather.elementAt(index).weatherCode.toInt(), isNight
                    ),
                    size: 20.0,
                    color: isNight ? Colors.white : Colors.black,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    isNight ? '${weeklyWeather.elementAt(index).minTemperature.toStringAsFixed(0)}°' : '${weeklyWeather.elementAt(index).maxTemperature.toStringAsFixed(0)}°',
                    style: TextStyle(
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyWeather(List<Weather> weeklyWeather, bool isNight) {
    List<Widget> dailyWeatherWidgets = [];
    for (var i = 1; i < 7; i++) {
      dailyWeatherWidgets.add(
        _buildDailyWeather(weeklyWeather, isNight, i),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dailyWeatherWidgets,
    );
  }

  IconData getWeatherIcon(int weatherCode, bool isNight) {
    if (isNight) {
      switch (weatherCode) {
        case 0:
          return WeatherIcons.night_clear;
        case 1:
        case 2:
        case 3:
          return WeatherIcons.night_alt_cloudy;
        case 45:
        case 48:
          return WeatherIcons.night_fog;
        case 51:
        case 53:
        case 55:
        case 80:
        case 81:
        case 82:
          return WeatherIcons.night_alt_showers;
        case 56:
        case 57:
          return WeatherIcons.night_alt_rain_mix;
        case 61:
        case 63:
        case 65:
          return WeatherIcons.night_alt_rain;
        case 66:
        case 67:
          return WeatherIcons.night_alt_sleet;
        case 71:
        case 73:
        case 75:
        case 77:
        case 85:
        case 86:
          return WeatherIcons.night_alt_snow;
        case 95:
          return WeatherIcons.night_alt_thunderstorm;
        case 96:
        case 99:
          return WeatherIcons.night_alt_snow_thunderstorm;
        default:
          return WeatherIcons.na;
      }
    }

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
}
