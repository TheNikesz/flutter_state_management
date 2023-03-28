import 'package:flutter/scheduler.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('end-to-end test', () {
    late FlutterDriver flutterDriver;
    late SchedulerBinding schedulerBinding;

    setUpAll(() async {
      flutterDriver = await FlutterDriver.connect();
      await flutterDriver.waitUntilFirstFrameRasterized();
      // flutterDriver.startTracing();

      // schedulerBinding = SchedulerBinding.instance;
      // schedulerBinding.addTimingsCallback((timings) {
      //   for (final timing in timings) {
      //     print('${timing.frameNumber}, ${timing.totalSpan.inMilliseconds};');
      //   }
      // });
    });

    tearDownAll(() async {
      flutterDriver.close();
    });

    test('weather', () async {
      await flutterDriver.waitFor(find.text('Warsaw'));

      // go to details and back
      await flutterDriver.tap(find.text('Thursday'));
      await flutterDriver.waitFor(find.text('Details'));
      await flutterDriver.tap(find.byTooltip('Back'));
      await flutterDriver.waitFor(find.text('Warsaw'));

      // go to settings, change to fahrenhait and favourite city to 'Lublin' and go back
      await flutterDriver.tap(find.byTooltip('Settings'));
      await flutterDriver.waitFor(find.text('Settings'));
      await flutterDriver
          .tap(find.byValueKey('SettingsTemperatureScaleSwitch'));
      await flutterDriver.waitFor(find.text('°F'));
      await flutterDriver.tap(find.byType('TextField'));
      await flutterDriver.enterText('Lublin');
      await flutterDriver.waitFor(find.text('Lublin'));
      await flutterDriver.tap(find.byValueKey("done-icon"));
      await flutterDriver.tap(find.byTooltip('Back'));
      await flutterDriver.waitFor(find.text('Warsaw'));

      // go to details and back
      await flutterDriver.tap(find.text('Thursday'));
      await flutterDriver.waitFor(find.text('Details'));
      await flutterDriver.tap(find.byTooltip('Back'));
      await flutterDriver.waitFor(find.text('Warsaw'));

      // enter 'Lublin' and search for weather
      await flutterDriver.tap(find.byType('TextField'));
      await flutterDriver.enterText('Lublin');
      await flutterDriver.waitFor(find.text('Lublin'));
      await flutterDriver.tap(find.byValueKey("search-icon"));
      await flutterDriver.waitFor(find.text('Lublin'));

      // change to night and chart
      await flutterDriver.tap(find.byValueKey('WeatherSwitch'));
      await flutterDriver.waitFor(find.text('Night'));
      await flutterDriver.tap(find.byValueKey('ChartSwitch'));
      await flutterDriver.waitFor(find.text('Chart'));
    });

    test('shared preferences', () async {
      await flutterDriver.waitFor(find.text('Lublin'));

      // change to night
      await flutterDriver.tap(find.byValueKey('WeatherSwitch'));
      await flutterDriver.waitFor(find.text('Night'));
    });
  });
}
