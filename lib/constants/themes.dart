import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxsav_companion/constants/luxsav_colors.dart';
import 'package:luxsav_companion/logic/controllers/theme_provider.dart';

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

  /// luxsav.com type, as the site actually renders it: Cormorant Garamond for
  /// every heading, card name and price (the site loads Playfair Display but
  /// never uses it), and Inter for everything else. Both are bundled in
  /// assets/fonts so text renders with no signal.
  static const String headingFont = 'CormorantGaramond';
  static const String bodyFont = 'Inter';

  static TextTheme _buildTextTheme(TextTheme base) {
    // The site sets large headings at 300–400; Cormorant is delicate, so the
    // smaller mobile title sizes use 500 to stay legible.
    TextStyle heading(TextStyle? s, {FontWeight weight = FontWeight.w400}) =>
        s!.copyWith(fontFamily: headingFont, fontWeight: weight, letterSpacing: 0);
    // The kit's Material defaults add letter spacing to body text; Inter is
    // designed to be set without it, which is how luxsav.com uses it.
    TextStyle body(TextStyle? s, {FontWeight? weight}) =>
        s!.copyWith(fontFamily: bodyFont, fontWeight: weight, letterSpacing: 0);

    return base.copyWith(
      displayLarge: heading(base.displayLarge),
      displayMedium: heading(base.displayMedium),
      displaySmall: heading(base.displaySmall),
      headlineLarge: heading(base.headlineLarge),
      headlineMedium: heading(base.headlineMedium),
      headlineSmall: heading(base.headlineSmall),
      // Screen titles (TextStyles.title) read from titleLarge, so they get the
      // serif; item titles and section labels (TextStyles.bold) stay in Inter.
      titleLarge: heading(base.titleLarge, weight: FontWeight.w500),
      titleMedium: body(base.titleMedium, weight: FontWeight.w600),
      titleSmall: body(base.titleSmall, weight: FontWeight.w500),
      bodyLarge: body(base.bodyLarge),
      bodyMedium: body(base.bodyMedium),
      bodySmall: body(base.bodySmall),
      labelLarge: body(base.labelLarge, weight: FontWeight.w500),
      labelMedium: body(base.labelMedium, weight: FontWeight.w500),
      labelSmall: body(base.labelSmall, weight: FontWeight.w500),
    );
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
