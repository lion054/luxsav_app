import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:luxsav_companion/constants/shared_preferences_keys.dart';
import 'package:luxsav_companion/constants/themes.dart';

class ThemeController extends GetxController {
  bool isLightMode = true;
  ThemeModeType themeModeType = ThemeModeType.system;

  ThemeController({
    required this.themeModeType,
  });

  static Future<ThemeController> init() async {
    ThemeController themeProvider = ThemeController(
      themeModeType: await SharedPreferencesKeys().getThemeMode(),
    );
    return themeProvider;
  }

  updateThemeMode(ThemeModeType themeModeTypeData) async {
    await SharedPreferencesKeys().setThemeMode(themeModeTypeData);
    final systembrightness = Get.context == null
        ? Brightness.light
        : MediaQuery.of(Get.context!).platformBrightness;
    checkAndSetThemeMode(
      themeModeTypeData == ThemeModeType.light
          ? Brightness.light
          : themeModeTypeData == ThemeModeType.dark
              ? Brightness.dark
              : systembrightness,
    );
  }

// this func is auto check theme and update them
  void checkAndSetThemeMode(Brightness systemBrightness) async {
    bool theLightTheme = isLightMode;

    // mode is selected by user
    themeModeType = await SharedPreferencesKeys().getThemeMode();
    if (themeModeType == ThemeModeType.system) {
      // if mode is system then we add as system birtness
      theLightTheme = systemBrightness == Brightness.light;
    } else if (themeModeType == ThemeModeType.dark) {
      theLightTheme = false;
    } else {
      //light theme selected by user
      theLightTheme = true;
    }

    if (isLightMode != theLightTheme) {
      isLightMode = theLightTheme;
      update();
    }
  }


}
