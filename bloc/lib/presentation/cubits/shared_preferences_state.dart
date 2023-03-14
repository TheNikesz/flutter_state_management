part of 'shared_preferences_cubit.dart';

@immutable
abstract class SharedPreferencesState {}

class SharedPreferencesInitial extends SharedPreferencesState {}

class SharedPreferencesSuccess extends SharedPreferencesState {
  final bool isFahrenheit;
  final bool isChart;
  final bool isNight;
  final String favouriteCity;
  
  SharedPreferencesSuccess({
    required this.isFahrenheit,
    required this.isChart,
    required this.isNight,
    required this.favouriteCity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SharedPreferencesSuccess &&
      other.isFahrenheit == isFahrenheit &&
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
