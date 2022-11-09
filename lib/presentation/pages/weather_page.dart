
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';
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
                  _buildSwitches(context, state.isChart, state.isNight),
                  const Spacer(),
                  if (state.isChart == true) ...[
                    _buildWeatherChart(state.weeklyWeather, state.isNight),
                  ] else _buildWeeklyWeather(state.weeklyWeather, state.isNight),
                  const Spacer(),
                ] else if (state is WeatherFailure) ...[
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.fmd_bad_outlined,
                      size: 50.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 2.0),
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Text(
                    'Please enter a new city name and try again.',
                    style: TextStyle(fontSize: 18),
                  ),
                  _buildCitySearch(context, false),
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
      padding: const EdgeInsets.only(top: 20.0, left: 40.0, right: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: _citySearchController,
                style: TextStyle(
                  color: isNight ? AppColors.nightText : AppColors.dayText,
                ),
                textAlign: TextAlign.left,
                cursorColor: isNight ? AppColors.nightText : AppColors.dayText,
                decoration: InputDecoration(
                  hintText: 'Enter a city name',
                  hintStyle: TextStyle(
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  ),
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
                          color: isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                          width: 2.0,
                        ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    borderSide:
                        BorderSide(
                          color: isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                          width: 2.0
                        ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            hoverColor: Colors.transparent,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isNight ? AppColors.nightLightGray : AppColors.dayLightGray,
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
      child: SizedBox(
        width: 350.0,
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
                      _getWeatherIcon(weeklyWeather.first.weatherCode.toInt(), isNight),
                      color: isNight ? Colors.white : Colors.black,
                      size: 80.0,
                    ),
                  ),
                  Text(
                    _getWeatherLabel(weeklyWeather.first.weatherCode.toInt()),
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
                  color: isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
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
      ),
    );
  }

  Widget _buildChartSwitch(BuildContext context, bool isNight, bool isGraph) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.reorder,
          color: isNight ? Colors.white : Colors.black,
        ),
        Switch(
          hoverColor: Colors.transparent,
          activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
          activeTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
          inactiveThumbColor: isNight ? AppColors.dayDarkGray : Colors.black,
          inactiveTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
          value: isGraph,
          onChanged: (value) {
            final weatherCubit = BlocProvider.of<WeatherCubit>(context);
            weatherCubit.changeGraphSwitchValue(value);
          },
        ),
        Icon(
          Icons.show_chart,
          color: isNight ? Colors.white : Colors.black,
        ),
      ],
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

  Widget _buildSwitches(BuildContext context, bool isChart, bool isNight) {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildChartSwitch(context, isNight, isChart),
          _buildWeatherSwitch(context, isNight)
        ],
      ),
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
                    _getWeatherIcon(
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

  Widget _buildWeatherChart(List<Weather> weeklyWeather, bool isNight) {
    List<double> maxTemperatures = [];
    List<double> minTemperatures = [];
    List<String> dates = [];

    for (var i = 0; i < weeklyWeather.length; i++) {
      maxTemperatures.add(weeklyWeather.elementAt(i).maxTemperature);
      minTemperatures.add(weeklyWeather.elementAt(i).minTemperature);
      dates.add(DateFormat('dd/MM').format(DateTime.parse(weeklyWeather.elementAt(i).date)));
    }

    var max = maxTemperatures.reduce((curr, next) => curr > next? curr: next) + 1;
    var min = minTemperatures.reduce((curr, next) => curr < next? curr: next) - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
      child: SizedBox(
        height: 400,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isNight ? AppColors.nightLightBlue : AppColors.dayLightGray,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
            child: Chart(
              data: isNight ? _getData(dates, minTemperatures, true) : _getData(dates, maxTemperatures, false),
              variables: _getVariables(isNight, max, min),
              elements: [LineElement(
                color: ColorAttr(
                  value: isNight ? AppColors.nightText : AppColors.dayText,
                ),
              )],
              axes: [
                Defaults.horizontalAxis
                ..grid = StrokeStyle(
                      color: isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                    )
                  ..line = null
                  ..label = LabelStyle(
                    offset: const Offset(0, 10),
                    align: Alignment.bottomCenter,
                    style: TextStyle(
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Defaults.verticalAxis
                  ..grid = StrokeStyle(
                      color: isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                    )
                  ..line = null
                  ..label = LabelStyle(
                    offset: const Offset(-10, 0),
                    align: Alignment.centerLeft,
                    style: TextStyle(
                      color: isNight ? AppColors.nightText : AppColors.dayText,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<dynamic, dynamic>> _getData(List<String> dates, List<double> temperatures, bool isNight) {
    if (isNight) {
      return [
        { 'night': dates.elementAt(0), 'minTemperature': temperatures.elementAt(0) },
        { 'night': dates.elementAt(1), 'minTemperature': temperatures.elementAt(1) },
        { 'night': dates.elementAt(2), 'minTemperature': temperatures.elementAt(2) },
        { 'night': dates.elementAt(3), 'minTemperature': temperatures.elementAt(3) },
        { 'night': dates.elementAt(4), 'minTemperature': temperatures.elementAt(4) },
        { 'night': dates.elementAt(5), 'minTemperature': temperatures.elementAt(5) },
        { 'night': dates.elementAt(6), 'minTemperature': temperatures.elementAt(6) },
      ];
    } else {
      return [
        { 'day': dates.elementAt(0), 'maxTemperature': temperatures.elementAt(0) },
        { 'day': dates.elementAt(1), 'maxTemperature': temperatures.elementAt(1) },
        { 'day': dates.elementAt(2), 'maxTemperature': temperatures.elementAt(2) },
        { 'day': dates.elementAt(3), 'maxTemperature': temperatures.elementAt(3) },
        { 'day': dates.elementAt(4), 'maxTemperature': temperatures.elementAt(4) },
        { 'day': dates.elementAt(5), 'maxTemperature': temperatures.elementAt(5) },
        { 'day': dates.elementAt(6), 'maxTemperature': temperatures.elementAt(6) },
      ];
    }
  }

  Map<String, Variable<Map<dynamic, dynamic>, dynamic>> _getVariables(bool isNight, double max, double min,) {
    if (isNight) {
      return {
        'night': Variable(
          accessor: (Map map) => map['night'] as String,
        ),
        'minTemperature': Variable(
          accessor: (Map map) => map['minTemperature'] as double,
          scale: LinearScale(
            min: min,
            max: max,
            formatter: (value) => value.toStringAsFixed(0)
          ),
        ),
      };
    } else {
      return {
        'day': Variable(
          accessor: (Map map) => map['day'] as String,
        ),
        'maxTemperature': Variable(
          accessor: (Map map) => map['maxTemperature'] as double,
          scale: LinearScale(
            min: min,
            max: max,
            formatter: (value) => value.toStringAsFixed(0)
          ),
        ),
      };
    }
  }

  IconData _getWeatherIcon(int weatherCode, bool isNight) {
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

  String _getWeatherLabel(int weatherCode) {
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