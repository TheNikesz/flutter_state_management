import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_colors.dart';
import '../controllers/providers.dart';

class SettingsChartSwitch extends ConsumerWidget {
  const SettingsChartSwitch({
    Key? key,
    required this.isNight,
    required this.isChart,
  }) : super(key: key);

  final bool isNight;
  final bool isChart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  key: const Key('SettingsChartSwitch'),
                  hoverColor: Colors.transparent,
                  activeColor: isNight ? AppColors.dayDarkGray : Colors.black,
                  activeTrackColor:
                      isNight ? AppColors.dayLightGray : Colors.black87,
                  inactiveThumbColor:
                      isNight ? AppColors.dayDarkGray : Colors.black,
                  inactiveTrackColor:
                      isNight ? AppColors.dayLightGray : Colors.black87,
                  value: isChart,
                  onChanged: (value) async {
                    SharedPreferences sharedPrefrences =
                        await SharedPreferences.getInstance();
                    sharedPrefrences.setBool('isChart', value);

                    ref.read(settingsProvider.notifier).state = ref
                        .read(settingsProvider.notifier)
                        .state
                        .copyWith(isChart: value);
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
