import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chart_switch_state.dart';

class ChartSwitchCubit extends Cubit<ChartSwitchState> {
  ChartSwitchCubit({required bool isChart}) : super(ChartSwitchState(isChart: isChart));

  Future<void> changeGraphSwitchValue(bool value) async {
    emit(state.copyWith(
      isChart: value,
    ));
  }
}