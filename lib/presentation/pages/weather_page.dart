import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_bloc/constants/app_colors.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../domain/models/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          _buildCitySearch(),
          const Spacer(),
          _buildMainWeather(),
          const Spacer(),
          // _buildDailyWeather(),
          _buildWeeklyWeather(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildCitySearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                // controller: _citySearchController,
                textAlign: TextAlign.center,
                cursorColor: AppColors.dayLightYellow,
                decoration: const InputDecoration(
                  hoverColor: Colors.transparent,
                  contentPadding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                    ),
                    borderSide: BorderSide(
                      color: AppColors.dayLightGray,
                      width: 2.0
                    ), 
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40)
                    ),
                    borderSide: BorderSide(
                      color: AppColors.dayLightYellow,
                      width: 2.0
                    ),
                  ),
                ),
                onSubmitted: (value) => null
              ),
            ),
          ),
          InkWell(
            hoverColor: Colors.transparent,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.dayLightYellow,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('Search')
              ),
            ),
            onTap: () {
              // FocusScope.of(context).unfocus();
              // ref.read(cityProvider.state).state = _searchController.text;
            },
          )
        ],
      ),
    );
  }

  Widget _buildMainWeather() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const BoxedIcon(WeatherIcons.day_rain,
            size: 80.0,
          ),
          const SizedBox(
            height: 150,
            child: VerticalDivider(
              color: AppColors.dayLightGray,
              thickness: 2,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('12°', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 100)),
              Text('Light rain', style: TextStyle(fontSize: 15))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyWeather() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 50.0
      ),
      child: SizedBox(
        height: 60,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            // color: AppColors.dayDarkGray,
            color: AppColors.dayLightYellow,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Wednesday'),
                BoxedIcon(WeatherIcons.day_rain,
                  size: 20.0,
                ),
                Text('14°'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyWeather() {
    List<Widget> _dailyWeatherWidgets = [];
    for(var i = 1; i < 7; i++) {
      _dailyWeatherWidgets.add(
        _buildDailyWeather(),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _dailyWeatherWidgets,
    );
  }

  // Widget _buildDayNightSwitch() {
  //   return SwitchListTile(value: value, onChanged: onChanged)
  // }
}