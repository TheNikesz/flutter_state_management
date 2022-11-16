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
  late bool isChart;
  late bool isNight;

  WeatherSuccess({required this.weeklyWeather, this.isNight = false, this.isChart = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WeatherSuccess &&
      listEquals(other.weeklyWeather, weeklyWeather) &&
      other.isChart == isChart &&
      other.isNight == isNight;
  }

  @override
  int get hashCode => weeklyWeather.hashCode ^ isChart.hashCode ^ isNight.hashCode;

  WeatherSuccess copyWith({
    List<Weather>? weeklyWeather,
    bool? isChart,
    bool? isNight,
  }) {
    return WeatherSuccess(
      weeklyWeather: weeklyWeather ?? this.weeklyWeather,
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
    );
  }
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
