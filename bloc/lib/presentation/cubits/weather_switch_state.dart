part of 'weather_switch_cubit.dart';

@immutable
class WeatherSwitchState {
  final bool isNight;

  const WeatherSwitchState({
    required this.isNight,
  });

  WeatherSwitchState copyWith({
    bool? isNight,
  }) {
    return WeatherSwitchState(
      isNight: isNight ?? this.isNight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WeatherSwitchState &&
      other.isNight == isNight;
  }

  @override
  int get hashCode => isNight.hashCode;
}
