import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_colors.dart';

class FavouriteCity extends ConsumerWidget {
  final TextEditingController _favouriteCityController;
  final bool isNight;

  FavouriteCity({
    Key? key,
    required this.isNight,
  })  : _favouriteCityController = TextEditingController(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
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
                    Icons.arrow_back,
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  )),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: _favouriteCityController,
                style: TextStyle(
                  color: isNight ? AppColors.nightText : AppColors.dayText,
                ),
                textAlign: TextAlign.center,
                cursorColor: isNight ? AppColors.nightText : AppColors.dayText,
                decoration: InputDecoration(
                  hintText: 'Enter a favourite city name',
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
                    Icons.done,
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  )),
            ),
            onTap: () async {
              SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
              sharedPrefrences.setString('favouriteCity', _favouriteCityController.text);
              
              final snackBar = SnackBar(
                content: Text('Favourite city was changed to: ${_favouriteCityController.text}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isNight ? AppColors.nightText : AppColors.dayText,
                  ),
                ),
                backgroundColor: isNight ? AppColors.nightLightBlue : AppColors.dayLightGray,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
    );
  }
}
