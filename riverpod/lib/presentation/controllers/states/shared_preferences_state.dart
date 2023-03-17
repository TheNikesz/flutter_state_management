class SharedPreferencesState {
  final bool isFahrenheit;
  final bool isChart;
  final bool isNight;
  final String favouriteCity;
  
  const SharedPreferencesState({
    required this.isFahrenheit,
    required this.isChart,
    required this.isNight,
    required this.favouriteCity,
  });
}
