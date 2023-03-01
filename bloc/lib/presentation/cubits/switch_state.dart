part of 'switch_cubit.dart';

@immutable
class SwitchState {
  final bool isNight;
  final bool isChart;

  const SwitchState({
    required this.isNight,
    required this.isChart,
  });

  SwitchState copyWith({
    bool? isNight,
    bool? isChart,
  }) {
    return SwitchState(
      isNight: isNight ?? this.isNight,
      isChart: isChart ?? this.isChart,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SwitchState &&
      other.isNight == isNight &&
      other.isChart == isChart;
  }

  @override
  int get hashCode => isNight.hashCode ^ isChart.hashCode;
}
