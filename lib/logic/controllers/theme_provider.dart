import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:luxsav_companion/constants/shared_preferences_keys.dart';
import 'package:luxsav_companion/constants/themes.dart';
import 'package:luxsav_companion/models/enum.dart';

class ThemeController extends GetxController {
  bool isLightMode = true;
  ThemeModeType themeModeType = ThemeModeType.system;
  FontFamilyType fontType = FontFamilyType.workSans;

  ThemeController({
    required this.themeModeType,
    required this.fontType,
  });

  static Future<ThemeController> init() async {
    ThemeController themeProvider = ThemeController(
      fontType: await SharedPreferencesKeys().getFontType(),
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

  void checkAndSetFonType() async {
    final FontFamilyType fontTypeData =
        await SharedPreferencesKeys().getFontType();
    if (fontTypeData != fontType) {
      fontType = fontTypeData;
      update();
    }
  }

  Future updateFontType(FontFamilyType fontTypeData) async {
    await SharedPreferencesKeys().setFontType(fontTypeData);
    fontType = fontTypeData;
    update();
  }

}
