// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChartSwitchContext {
  final bool isChart;
  ChartSwitchContext({
    required this.isChart,
  });

  ChartSwitchContext copyWith({
    bool? isChart,
  }) {
    return ChartSwitchContext(
      isChart: isChart ?? this.isChart,
    );
  }

  @override
  bool operator ==(covariant ChartSwitchContext other) {
    if (identical(this, other)) return true;

    return other.isChart == isChart;
  }

  @override
  int get hashCode => isChart.hashCode;
}
