part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherSuccess extends WeatherState {
  final List<Weather> weeklyWeather;

  const WeatherSuccess({required this.weeklyWeather});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WeatherSuccess &&
      listEquals(other.weeklyWeather, weeklyWeather);
  }

  @override
  int get hashCode => weeklyWeather.hashCode;
}

class WeatherFailure extends WeatherState {
  final String errorMessage;

  const WeatherFailure(this.errorMessage);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WeatherFailure &&
      other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
