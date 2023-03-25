import 'package:flutter/material.dart';

import '../state/context/settings_context.dart';

class SettingsInheritedWidget extends InheritedWidget {
  const SettingsInheritedWidget(this.settingsContext,
      {Key? key, required Widget child})
      : super(key: key, child: child);

  final SettingsContext settingsContext;

  static SettingsContext of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SettingsInheritedWidget>()!
        .settingsContext;
  }

  @override
  bool updateShouldNotify(SettingsInheritedWidget oldWidget) {
    return settingsContext != oldWidget.settingsContext;
  }
}
