import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:weather_app_bloc/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('weather', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Warsaw'), findsOneWidget);

      // go to details and back
      await tester.tap(find.text('Thursday'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // go to settings, change to fahrenhait and favourite city to 'Lublin' and go back
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('SettingsTemperatureScaleSwitch')));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Lublin');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.done));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // go to details and back
      await tester.tap(find.text('Thursday'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // enter 'Lublin' and search for weather
      await tester.enterText(find.byType(TextField), 'Lublin');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // change to night and chart
      await tester.tap(find.byKey(const Key('WeatherSwitch')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('ChartSwitch')));
      await tester.pumpAndSettle();

      expect(find.text('Lublin'), findsOneWidget);
    });

    testWidgets('shared preferences', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Lublin'), findsOneWidget);

      // change to night
      await tester.tap(find.byKey(const Key('WeatherSwitch')));
      await tester.pumpAndSettle();

      expect(find.text('Lublin'), findsOneWidget);
    });
  });
}