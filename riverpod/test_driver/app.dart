import 'package:weather_app_riverpod/main.dart' as app;
import 'package:flutter/scheduler.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  late SchedulerBinding schedulerBinding;
  enableFlutterDriverExtension();
  app.main();
  schedulerBinding = SchedulerBinding.instance;
  schedulerBinding.addTimingsCallback((timings) {
    for (final timing in timings) {
      print('${timing.frameNumber}, ${timing.totalSpan.inMicroseconds};');
    }
  });
}