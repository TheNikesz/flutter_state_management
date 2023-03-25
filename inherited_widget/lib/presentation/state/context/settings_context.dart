// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingsContext {
  final bool isFahrenheit;
  final bool isChart;
  final bool isNight;

  SettingsContext({
    required this.isFahrenheit,
    required this.isChart,
    required this.isNight,
  });

  SettingsContext copyWith({
    bool? isFahrenheit,
    bool? isChart,
    bool? isNight,
  }) {
    return SettingsContext(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
    );
  }

  @override
  bool operator ==(covariant SettingsContext other) {
    if (identical(this, other)) return true;

    return other.isFahrenheit == isFahrenheit &&
        other.isChart == isChart &&
        other.isNight == isNight;
  }

  @override
  int get hashCode =>
      isFahrenheit.hashCode ^ isChart.hashCode ^ isNight.hashCode;
}
