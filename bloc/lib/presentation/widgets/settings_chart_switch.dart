import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../cubits/settings_cubit.dart';

class SettingsChartSwitch extends StatelessWidget {
  const SettingsChartSwitch({
    Key? key,
    required this.isNight,
    required this.isChart,
  }) : super(key: key);

  final bool isNight;
  final bool isChart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 50.0),
      child: SizedBox(
        height: 60,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isNight ? AppColors.nightLightBlue : AppColors.dayLightGray,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.reorder,
                  color: isNight ? Colors.white : Colors.black,
                ),
                Switch(
                  hoverColor: Colors.transparent,
                  activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
                  activeTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
                  inactiveThumbColor: isNight ? AppColors.dayDarkGray : Colors.black,
                  inactiveTrackColor: isNight ? AppColors.dayLightGray : Colors.black87,
                  value: isChart,
                  onChanged: (value) {
                    final settingsCubit = BlocProvider.of<SettingsCubit>(context);
                    settingsCubit.changeSettingsChartSwitchValue(value);
                  },
                ),
                Icon(
                  Icons.show_chart,
                  color: isNight ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}