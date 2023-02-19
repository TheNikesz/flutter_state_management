import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_bloc/presentation/controllers/providers.dart';

import '../../constants/app_colors.dart';

class CitySearch extends ConsumerWidget {
  final TextEditingController _citySearchController;
  final bool isNight;

  CitySearch({
    Key? key,
    required this.isNight,
  }) : _citySearchController = TextEditingController(), super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: _citySearchController,
                style: TextStyle(
                  color: isNight ? AppColors.nightText : AppColors.dayText,
                ),
                textAlign: TextAlign.left,
                cursorColor: isNight ? AppColors.nightText : AppColors.dayText,
                decoration: InputDecoration(
                  hintText: 'Enter a city name',
                  hintStyle: TextStyle(
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  ),
                  hoverColor: Colors.transparent,
                  contentPadding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  fillColor: isNight ? AppColors.nightDarkBlue : Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    borderSide:
                        BorderSide(
                          color: isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                          width: 2.0,
                        ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    borderSide:
                        BorderSide(
                          color: isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                          width: 2.0
                        ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            hoverColor: Colors.transparent,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isNight ? AppColors.nightLightGray : AppColors.dayLightGray,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  Icons.search,
                  color: isNight ? AppColors.nightText : AppColors.dayText,
                )
              ),
            ),
            onTap: () {
              ref.read(switchProvider.notifier).state = ref.read(switchProvider.notifier).state.copyWith(isNight: false, isChart: false);
              ref.read(cityProvider.notifier).state = _citySearchController.text;
              // ref.read(weatherProvider(_citySearchController.text));
            },
          )
        ],
      ),
    );
  }
}