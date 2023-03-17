import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class WeatherDetailsBackButton extends StatelessWidget {
  final bool isNight;

  const WeatherDetailsBackButton({super.key, required this.isNight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back,
            color: isNight ? AppColors.nightText : AppColors.dayText,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}