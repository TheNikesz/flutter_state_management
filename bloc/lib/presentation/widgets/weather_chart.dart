import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_bloc/constants/temperature_calculator.dart';

import '../../constants/app_colors.dart';
import '../../domain/models/weather.dart';

class WeatherChart extends StatelessWidget {
  final List<Weather> weeklyWeather;
  final bool isNight;
  final bool isFahrenheit;

  const WeatherChart({
    Key? key,
    required this.weeklyWeather,
    required this.isNight,
    required this.isFahrenheit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> maxTemperatures = [];
    List<int> minTemperatures = [];
    List<String> dates = [];

    for (var i = 0; i < weeklyWeather.length; i++) {
      maxTemperatures.add(TemperatureCalculator.getTemperature(weeklyWeather.elementAt(i).maxTemperature, isFahrenheit));
      minTemperatures.add(TemperatureCalculator.getTemperature(weeklyWeather.elementAt(i).minTemperature, isFahrenheit));
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

  List<Map<dynamic, dynamic>> _getData(List<String> dates, List<int> temperatures, bool isNight) {
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

  Map<String, Variable<Map<dynamic, dynamic>, dynamic>> _getVariables(bool isNight, int max, int min,) {
    if (isNight) {
      return {
        'night': Variable(
          accessor: (Map map) => map['night'] as String,
        ),
        'minTemperature': Variable(
          accessor: (Map map) => map['minTemperature'] as int,
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
          accessor: (Map map) => map['maxTemperature'] as int,
          scale: LinearScale(
            min: min,
            max: max,
            formatter: (value) => value.toStringAsFixed(0)
          ),
        ),
      };
    }
  }
}