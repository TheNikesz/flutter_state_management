part of 'chart_switch_cubit.dart';

@immutable
class ChartSwitchState {
  final bool isChart;

  const ChartSwitchState({
    required this.isChart,
  });

  ChartSwitchState copyWith({
    bool? isChart,
  }) {
    return ChartSwitchState(
      isChart: isChart ?? this.isChart,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChartSwitchState &&
      other.isChart == isChart;
  }

  @override
  int get hashCode => isChart.hashCode;
}
