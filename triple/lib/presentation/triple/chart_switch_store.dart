import 'package:flutter_triple/flutter_triple.dart';

class ChartSwitchStore extends Store<bool> {
  ChartSwitchStore(super.initialState);

  void changeGraphSwitchValue(bool value) {
    update(value);
  }
}
