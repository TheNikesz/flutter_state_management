import 'package:weather_app_bloc/domain/models/weather.dart';

class WeatherState {
  List<Weather>? weeklyWeather;
  bool isLoading = true;
  bool isChart = false;
  bool isNight = false;
}
