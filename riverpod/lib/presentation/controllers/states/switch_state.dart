class SwitchState {
  final bool isNight;
  final bool isChart;

  const SwitchState({required this.isNight, required this.isChart});

  SwitchState copyWith({bool? isNight, bool? isChart}) {
    return SwitchState(
      isNight: isNight ?? this.isNight,
      isChart: isChart ?? this.isChart,
    );
  }
}