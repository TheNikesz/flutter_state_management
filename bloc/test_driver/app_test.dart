import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('end-to-end test', () {
    late FlutterDriver flutterDriver;

    setUpAll(() async {
      flutterDriver = await FlutterDriver.connect();
      flutterDriver.startTracing();
      await flutterDriver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      final timeline = await flutterDriver.stopTracingAndDownloadTimeline();
      final TimelineSummary summary = TimelineSummary.summarize(timeline);
      await summary.writeTimelineToFile(DateTime.now().toIso8601String(),
          pretty: true);
      flutterDriver.close();
    });

    test('weather', () async {
      print("pid: $pid");
      await flutterDriver.waitFor(find.text('Friday'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // go to details and back
      await flutterDriver.tap(find.text('Thursday'));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await flutterDriver.waitFor(find.text('Sunrise'));
      await flutterDriver.tap(find.byValueKey('back-icon'));
      await flutterDriver.waitFor(find.text('Friday'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // go to settings, change to fahrenhait and favourite city to 'Lublin' and go back
      await flutterDriver.tap(find.byValueKey('settings-icon'));
      await flutterDriver.waitFor(find.text('Enter a favourite city name'));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await flutterDriver
          .tap(find.byValueKey('SettingsTemperatureScaleSwitch'));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await flutterDriver.tap(find.byType('TextField'));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await flutterDriver.enterText('Lublin');
      await flutterDriver.waitFor(find.text('Lublin'));
      await Future<void>.delayed(const Duration(milliseconds: 250));
      await flutterDriver.tap(find.byValueKey("done-icon"));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await flutterDriver.tap(find.byValueKey('back-settings-icon'));
      await flutterDriver.waitFor(find.text('Friday'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // go to details and back
      await flutterDriver.tap(find.text('Thursday'));
      await flutterDriver.waitFor(find.text('Sunrise'));
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await flutterDriver.tap(find.byValueKey('back-icon'));
      await flutterDriver.waitFor(find.text('Friday'));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // enter 'Lublin' and search for weather
      await flutterDriver.tap(find.byType('TextField'));
      await flutterDriver.enterText('Lublin');
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await flutterDriver.waitFor(find.text('Lublin'));
      await flutterDriver.tap(find.byValueKey("search-icon"));
      await Future<void>.delayed(const Duration(milliseconds: 2000));

      // change to night and chart
      await flutterDriver.tap(find.byValueKey('WeatherSwitch'));
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await flutterDriver.tap(find.byValueKey('ChartSwitch'));
      await Future<void>.delayed(const Duration(milliseconds: 500));
    });

    test('shared preferences', () async {
      await flutterDriver.waitFor(find.text('Lublin'));

      // change to night
      await flutterDriver.tap(find.byValueKey('WeatherSwitch'));
      await Future<void>.delayed(const Duration(milliseconds: 500));
    });
  });
}
