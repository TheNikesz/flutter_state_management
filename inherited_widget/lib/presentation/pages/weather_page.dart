import 'package:flutter/material.dart';
import 'package:weather_app_inherited_widget/presentation/inherited_widgets/chart_switch_inherited_widget.dart';
import 'package:weather_app_inherited_widget/presentation/inherited_widgets/settings_inherited_widget.dart';
import 'package:weather_app_inherited_widget/presentation/inherited_widgets/weather_inherited_widget.dart';

import '../../constants/app_colors.dart';
import '../inherited_widgets/weather_switch_inherited_widget.dart';
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
    final weatherState = WeatherInheritedWidget.of(context);
    final settingsState = SettingsInheritedWidget.of(context);
    final chartSwitchState = ChartSwitchInheritedWidget.of(context);
    final weatherSwitchState = WeatherSwitchInheritedWidget.of(context);

    return Scaffold(
      backgroundColor: WeatherSwitchInheritedWidget.of(context).isNight == true
          ? AppColors.nightDarkBlue
          : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (weatherState.errorMessage != null) ...[
            const Spacer(),
            _buildError(weatherState.errorMessage!,
                WeatherSwitchInheritedWidget.of(context).isNight),
            const Spacer(),
          ] else if (!weatherState.isLoading &&
              weatherState.weeklyWeather != null) ...[
            const Spacer(),
            CitySearch(isNight: weatherSwitchState.isNight),
            const Spacer(),
            CityAndDate(
                weather: weatherState.weeklyWeather!.first,
                isNight: weatherSwitchState.isNight),
            const Spacer(),
            MainWeather(
              weather: weatherState.weeklyWeather!.first,
              isNight: weatherSwitchState.isNight,
              isFahrenheit: settingsState.isFahrenheit,
            ),
            const Spacer(),
            _buildSwitches(
                chartSwitchState.isChart, weatherSwitchState.isNight),
            const Spacer(),
            chartSwitchState.isChart == true
                ? WeatherChart(
                    weeklyWeather: weatherState.weeklyWeather!,
                    isNight: weatherSwitchState.isNight,
                    isFahrenheit: settingsState.isFahrenheit,
                  )
                : SizedBox(
                    height: 410,
                    child: ListView.builder(
                      itemCount: weatherState.weeklyWeather!.skip(1).length,
                      itemBuilder: (BuildContext context, int index) {
                        return DailyWeather(
                            weather: weatherState.weeklyWeather!
                                .skip(1)
                                .elementAt(index),
                            isNight: weatherSwitchState.isNight,
                            isFahrenheit: settingsState.isFahrenheit);
                      },
                    ),
                  ),
            const Spacer(),
          ] else
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  weatherSwitchState.isNight
                      ? AppColors.nightText
                      : AppColors.dayText,
                ),
              ),
            ),
        ],
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

  Widget _buildError(String errorMessage, bool isNight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: SizedBox(
              height: 180,
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
                              textAlign: TextAlign.center,
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
                              textAlign: TextAlign.center,
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: CitySearch(isNight: isNight),
        ),
      ],
    );
  }
}
