class SwitchState {
  late bool isChart;
  late bool isNight;

  SwitchState({this.isNight = false, this.isChart = false});

  SwitchState copyWith({
    bool? isChart,
    bool? isNight,
  }) {
    return SwitchState(
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
    );
  }

  @override
  bool operator ==(covariant SwitchState other) {
    if (identical(this, other)) return true;

    return other.isChart == isChart && other.isNight == isNight;
  }

  @override
  int get hashCode => isChart.hashCode ^ isNight.hashCode;
}
