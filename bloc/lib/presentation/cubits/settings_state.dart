part of 'settings_cubit.dart';

@immutable
class SettingsState {
  final bool isFahrenheit;
  final bool isChart;
  final bool isNight;

  const SettingsState({
    required this.isFahrenheit,
    required this.isChart,
    required this.isNight, 
  });

  
  SettingsState copyWith({
    bool? isFahrenheit,
    bool? isChart,
    bool? isNight,
  }) {
    return SettingsState(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SettingsState &&
      other.isFahrenheit == isFahrenheit &&
      other.isChart == isChart &&
      other.isNight == isNight;
  }

  @override
  int get hashCode => isFahrenheit.hashCode ^ isChart.hashCode ^ isNight.hashCode;
}
