class SettingsState {
  final bool isFahrenheit;
  final bool isNight;
  final bool isChart;

  const SettingsState({
    required this.isFahrenheit,
    required this.isNight,
    required this.isChart,
  });

  SettingsState copyWith({
    bool? isFahrenheit,
    bool? isNight,
    bool? isChart,
  }) {
    return SettingsState(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
      isNight: isNight ?? this.isNight,
      isChart: isChart ?? this.isChart,
    );
  }
}
