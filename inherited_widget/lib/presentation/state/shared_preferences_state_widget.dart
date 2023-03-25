import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_inherited_widget/presentation/inherited_widgets/shared_preferences_inherited_widget.dart';
import 'package:weather_app_inherited_widget/presentation/state/context/shared_preferences_context.dart';

class SharedPreferencesStateWidget extends StatefulWidget {
  const SharedPreferencesStateWidget({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  static SharedPreferencesStateWidgetState of(BuildContext context) {
    return context
        .findAncestorStateOfType<SharedPreferencesStateWidgetState>()!;
  }

  @override
  State<SharedPreferencesStateWidget> createState() =>
      SharedPreferencesStateWidgetState();
}

class SharedPreferencesStateWidgetState
    extends State<SharedPreferencesStateWidget> {
  SharedPreferencesContext _sharedPreferencesContext =
      SharedPreferencesContext();

  @override
  void initState() {
    super.initState();
    getSettingsFromSharedPreferences();
  }

  Future<void> getSettingsFromSharedPreferences() async {
    _sharedPreferencesContext =
        _sharedPreferencesContext.copyWith(isLoading: true);

    final sharedPreferences = await SharedPreferences.getInstance();
    final bool? isFahrenheit = sharedPreferences.getBool('isFahrenheit');
    final bool? isChart = sharedPreferences.getBool('isChart');
    final bool? isNight = sharedPreferences.getBool('isNight');
    final String? favouriteCity = sharedPreferences.getString('favouriteCity');

    setState(() {
      _sharedPreferencesContext = _sharedPreferencesContext.copyWith(
        isFahrenheit: isFahrenheit ?? false,
        isChart: isChart ?? false,
        isNight: isNight ?? false,
        favouriteCity: favouriteCity ?? 'Warsaw',
        isLoading: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SharedPreferencesInheritedWidget(_sharedPreferencesContext,
        child: widget.child);
  }
}
