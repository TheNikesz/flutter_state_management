import 'package:flutter/material.dart';

import '../state/context/shared_preferences_context.dart';

class SharedPreferencesInheritedWidget extends InheritedWidget {
  const SharedPreferencesInheritedWidget(this.sharedPreferencesContext,
      {Key? key, required Widget child})
      : super(key: key, child: child);

  final SharedPreferencesContext sharedPreferencesContext;

  static SharedPreferencesContext of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SharedPreferencesInheritedWidget>()!
        .sharedPreferencesContext;
  }

  @override
  bool updateShouldNotify(SharedPreferencesInheritedWidget oldWidget) {
    return sharedPreferencesContext != oldWidget.sharedPreferencesContext;
  }
}
