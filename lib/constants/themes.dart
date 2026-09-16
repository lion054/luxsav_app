import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxsav_companion/constants/luxsav_colors.dart';
import 'package:luxsav_companion/logic/controllers/theme_provider.dart';
import 'package:luxsav_companion/models/enum.dart';

class AppTheme {
  static bool get isLightMode {
    try {
      return Get.find<ThemeController>().isLightMode;
    } catch (e) {
      return true;
    }
  }

  // Colours — the LuxSav brand is fixed (see LuxColors), unlike the kit, which
  // let users pick an accent. Green leads on light surfaces; on dark surfaces the
  // site's own rule applies and gold takes over.
  static Color get primaryColor =>
      isLightMode ? LuxColors.green : LuxColors.gold;

  /// Text and icons placed on [primaryColor].
  static Color get onPrimaryColor =>
      isLightMode ? LuxColors.white : LuxColors.charcoal;

  /// Gold for text and icons: the darker variant on light backgrounds.
  static Color get goldTextColor =>
      isLightMode ? LuxColors.goldOnLight : LuxColors.gold;

  static Color get scaffoldBackgroundColor =>
      isLightMode ? LuxColors.ivory : LuxColors.charcoal;

  static Color get redErrorColor => const Color(0xFFAC0000);

  static Color get backgroundColor =>
      isLightMode ? LuxColors.white : LuxColors.darkSurface;

  static Color get primaryTextColor =>
      isLightMode ? LuxColors.charcoal : LuxColors.ivory;

  static Color get secondaryTextColor =>
      isLightMode ? LuxColors.mutedOnLight : LuxColors.mutedOnDark;

  static Color get whiteColor => LuxColors.white;
  static Color get backColor => LuxColors.charcoal;

  static Color get fontcolor =>
      isLightMode ? LuxColors.charcoal : LuxColors.ivory;

  static ThemeData get getThemeData =>
      isLightMode ? _buildLightTheme() : _buildDarkTheme();

  static Color get dividerColor =>
      isLightMode ? LuxColors.border : LuxColors.darkBorder;

  static TextTheme _buildTextTheme(TextTheme base) {
    FontFamilyType fontType = FontFamilyType.workSans;
    try {
      fontType = Get.find<ThemeController>().fontType;
    } catch (_) {}

    return base.copyWith(
      displayLarge: getTextStyle(fontType, base.displayLarge!), //f-size 96
      displayMedium: getTextStyle(fontType, base.displayMedium!), //f-size 60
      displaySmall: getTextStyle(fontType, base.displaySmall!), //f-size 48
      headlineMedium: getTextStyle(fontType, base.headlineMedium!), //f-size 34
      headlineSmall: getTextStyle(fontType, base.headlineSmall!), //f-size 24
      titleLarge: getTextStyle(
        fontType,
        base.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      ), //f-size 20
      labelLarge: getTextStyle(fontType, base.labelLarge!), //f-size 14
      bodySmall: getTextStyle(fontType, base.bodySmall!), //f-size 12
      bodyLarge: getTextStyle(fontType, base.bodyLarge!), //f-size 16
      bodyMedium: getTextStyle(fontType, base.bodyMedium!), //f-size 14
      titleMedium: getTextStyle(
        fontType,
        base.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ), //f-size 16
      titleSmall: getTextStyle(fontType, base.titleSmall!), //f-size 14
      labelSmall: getTextStyle(fontType, base.labelSmall!), //f-size 10
    );
  }

  static TextStyle getTextStyle(
    FontFamilyType fontFamilyType,
    TextStyle textStyle,
  ) {
    switch (fontFamilyType) {
      case FontFamilyType.montserrat:
        return GoogleFonts.montserrat(textStyle: textStyle);
      case FontFamilyType.workSans:
        return GoogleFonts.workSans(textStyle: textStyle);
      case FontFamilyType.varela:
        return GoogleFonts.varela(textStyle: textStyle);
      case FontFamilyType.satisfy:
        return GoogleFonts.satisfy(textStyle: textStyle);
      case FontFamilyType.dancingScript:
        return GoogleFonts.dancingScript(textStyle: textStyle);
      case FontFamilyType.kaushanScript:
        return GoogleFonts.kaushanScript(textStyle: textStyle);
    }
  }

  static ThemeData _buildLightTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: goldTextColor,
      surface: backgroundColor,
      error: redErrorColor,
    );
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      dividerColor: dividerColor,
      dividerTheme: DividerThemeData(color: dividerColor),
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData _buildDarkTheme() {
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: goldTextColor,
      surface: backgroundColor,
      error: redErrorColor,
    );
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      dividerColor: dividerColor,
      dividerTheme: DividerThemeData(color: dividerColor),
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static DialogThemeData _dialogTheme() {
    return DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }

  static CardThemeData _cardTheme() {
    return CardThemeData(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      surfaceTintColor: Colors.transparent,
      shadowColor: secondaryTextColor.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8,
      margin: const EdgeInsets.all(0),
    );
  }

  static get mapCardDecoration => BoxDecoration(
    color: AppTheme.scaffoldBackgroundColor,
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: AppTheme.getThemeData.dividerColor,
        offset: const Offset(4, 4),
        blurRadius: 8.0,
      ),
    ],
  );
  static get buttonDecoration => BoxDecoration(
    color: AppTheme.primaryColor,
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: AppTheme.getThemeData.dividerColor,
        blurRadius: 8,
        offset: const Offset(4, 4),
      ),
    ],
  );
  static get searchBarDecoration => BoxDecoration(
    color: AppTheme.scaffoldBackgroundColor,
    borderRadius: const BorderRadius.all(Radius.circular(38)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: AppTheme.getThemeData.dividerColor,
        blurRadius: 8,
        // offset: Offset(4, 4),
      ),
    ],
  );

  static get boxDecoration => BoxDecoration(
    color: AppTheme.scaffoldBackgroundColor,
    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: AppTheme.getThemeData.dividerColor,
        //   offset: Offset(2, 2),
        blurRadius: 8,
      ),
    ],
  );
}

enum ThemeModeType { system, dark, light }
