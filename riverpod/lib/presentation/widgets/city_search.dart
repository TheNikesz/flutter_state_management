import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../controllers/providers.dart';
import '../pages/weather_settings_page.dart';

class CitySearch extends ConsumerWidget {
  final TextEditingController _citySearchController;
  final bool isNight;

  CitySearch({
    Key? key,
    required this.isNight,
  })  : _citySearchController = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            hoverColor: Colors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Icon(
                    key: const Key('settings-icon'),
                    Icons.settings_outlined,
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  )),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeatherSettingsPage(
                            isNight: isNight,
                          )));
            },
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: _citySearchController,
                style: TextStyle(
                  color: isNight ? AppColors.nightText : AppColors.dayText,
                ),
                textAlign: TextAlign.center,
                cursorColor: isNight ? AppColors.nightText : AppColors.dayText,
                decoration: InputDecoration(
                  hintText: 'Enter a city name',
                  hintStyle: TextStyle(
                    height: 3.15,
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  ),
                  hoverColor: Colors.transparent,
                  fillColor: isNight ? AppColors.nightDarkBlue : Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: isNight
                          ? AppColors.nightLightGray
                          : AppColors.dayDarkGray,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                        color: isNight
                            ? AppColors.nightLightGray
                            : AppColors.dayDarkGray,
                        width: 2.0),
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
                color:
                    isNight ? AppColors.nightLightGray : AppColors.dayDarkGray,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Icon(
                    key: const Key("search-icon"),
                    Icons.search,
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  )),
            ),
            onTap: () {
              ref.read(cityProvider.notifier).state =
                  _citySearchController.text;
            },
          )
        ],
      ),
    );
  }
}
