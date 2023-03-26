// ignore_for_file: public_member_api_docs, sort_constructors_first
class SharedPreferencesContext {
  final bool isFahrenheit;
  final bool isChart;
  final bool isNight;
  final String favouriteCity;
  final bool isLoading;

  SharedPreferencesContext({
    this.isFahrenheit = false,
    this.isChart = false,
    this.isNight = false,
    this.favouriteCity = 'Warsaw',
    this.isLoading = true,
  });

  SharedPreferencesContext copyWith({
    bool? isFahrenheit,
    bool? isChart,
    bool? isNight,
    String? favouriteCity,
    bool? isLoading,
  }) {
    return SharedPreferencesContext(
      isFahrenheit: isFahrenheit ?? this.isFahrenheit,
      isChart: isChart ?? this.isChart,
      isNight: isNight ?? this.isNight,
      favouriteCity: favouriteCity ?? this.favouriteCity,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(covariant SharedPreferencesContext other) {
    if (identical(this, other)) return true;

    return other.isFahrenheit == isFahrenheit &&
        other.isChart == isChart &&
        other.isNight == isNight &&
        other.favouriteCity == favouriteCity &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode {
    return isFahrenheit.hashCode ^
        isChart.hashCode ^
        isNight.hashCode ^
        favouriteCity.hashCode ^
        isLoading.hashCode;
  }
}
