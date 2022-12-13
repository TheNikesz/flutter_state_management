import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_labels.dart';
import '../../domain/models/weather.dart';

class WeatherBlock extends StatelessWidget {
  final String firstLabel;
  final bool isFirstIconWeather;
  final IconData firstIcon;
  final String firstValue;
  final String secondLabel;
  final bool isSecondIconWeather;
  final IconData secondIcon;
  final String secondValue;
  final bool isNight;

  const WeatherBlock({
    Key? key,
    required this.firstLabel,
    required this.isFirstIconWeather,
    required this.firstIcon,
    required this.firstValue,
    required this.secondLabel,
    required this.isSecondIconWeather,
    required this.secondIcon,
    required this.secondValue,
    required this.isNight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
      child: SizedBox(
        height: 85,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      firstLabel,
                      style: TextStyle(
                        color: isNight ? AppColors.nightText : AppColors.dayText,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isFirstIconWeather ? BoxedIcon(
                          firstIcon,
                          size: 15,
                          color: isNight ? Colors.white : Colors.black,
                        ) : Icon(
                          firstIcon,
                          size: 15,
                          color: isNight ? Colors.white : Colors.black,
                        ),
                        SizedBox(
                          width: 70,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              firstValue,
                              style: TextStyle(
                                color: isNight ? AppColors.nightText : AppColors.dayText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      secondLabel,
                      style: TextStyle(
                        color: isNight ? AppColors.nightText : AppColors.dayText,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isSecondIconWeather ? BoxedIcon(
                          secondIcon,
                          size: 15,
                          color: isNight ? Colors.white : Colors.black,
                        ) : Icon(
                          secondIcon,
                          size: 15,
                          color: isNight ? Colors.white : Colors.black,
                        ),
                        SizedBox(
                          width: 70,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              secondValue,
                              style: TextStyle(
                                color: isNight ? AppColors.nightText : AppColors.dayText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
