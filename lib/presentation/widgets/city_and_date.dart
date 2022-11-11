import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../domain/models/weather.dart';

class CityAndDate extends StatelessWidget {
  final Weather weather;
  final bool isNight;

  const CityAndDate({
    Key? key,
    required this.weather,
    required this.isNight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(weather.cityName,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40,
                  color: isNight ? AppColors.nightText : AppColors.dayText,
              )
            ),
          Text(
            DateFormat('EEE dd/MM/yy').format(DateTime.parse(weather.date)),
            style: TextStyle(
              color: isNight ? AppColors.nightText : AppColors.dayText,
            ),
          ),
        ],
      ),
    );
  }
}