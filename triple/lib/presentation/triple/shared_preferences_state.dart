// ignore_for_file: public_member_api_docs, sort_constructors_first
class SharedPreferencesState {
  final bool isFahrenheit;
  final bool isChart;
  final bool isNight;
  final String favouriteCity;

  SharedPreferencesState({
    this.isFahrenheit = false,
    this.isChart = false,
    this.isNight = false,
    this.favouriteCity = 'Warsaw',
  });

  SharedPreferencesState copyWith({
    bool? isFahrenheit,
    bool? isChart,
    bool? isNight,
    String? favouriteCity,
  }) {
    return SharedPreferencesState(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
      favouriteCity: favouriteCity ?? this.favouriteCity,
    );
  }

  @override
  bool operator ==(covariant SharedPreferencesState other) {
    if (identical(this, other)) return true;

    return other.isFahrenheit == isFahrenheit &&
        other.isChart == isChart &&
        other.isNight == isNight &&
        other.favouriteCity == favouriteCity;
  }

  @override
  int get hashCode {
    return isFahrenheit.hashCode ^
        isChart.hashCode ^
        isNight.hashCode ^
        favouriteCity.hashCode;
  }
}
