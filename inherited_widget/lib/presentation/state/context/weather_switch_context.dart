// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherSwitchContext {
  final bool isNight;

  WeatherSwitchContext({required this.isNight});

  WeatherSwitchContext copyWith({
    bool? isNight,
  }) {
    return WeatherSwitchContext(
      isNight: isNight ?? this.isNight,
    );
  }

  @override
  bool operator ==(covariant WeatherSwitchContext other) {
    if (identical(this, other)) return true;

    return other.isNight == isNight;
  }

  @override
  int get hashCode => isNight.hashCode;
}
