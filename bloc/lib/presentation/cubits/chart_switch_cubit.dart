import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chart_switch_state.dart';

class ChartSwitchCubit extends Cubit<ChartSwitchState> {
  ChartSwitchCubit() : super(const ChartSwitchState(isChart: false));

  void changeGraphSwitchValue(bool value) {
    emit(state.copyWith(
      isChart: value,
    ));
  }
}