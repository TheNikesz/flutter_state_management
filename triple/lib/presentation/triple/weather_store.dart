import 'package:flutter_triple/flutter_triple.dart';
import 'package:weather_app_triple/presentation/triple/weather_success.dart';

class WeatherStore extends StreamStore<Exception, WeatherSuccess> {
  WeatherStore() : super(WeatherSuccess(weeklyWeather: []));
}
