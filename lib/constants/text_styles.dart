import 'package:flutter/material.dart';
import 'package:luxsav_companion/constants/themes.dart';

class TextStyles {
  final BuildContext context;

  TextStyles(this.context);

  TextStyle title() {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
      // 30 rather than the kit's 24: Cormorant sets noticeably smaller than
      // the sans-serif the kit was sized for.
      fontSize: 30,
      color: AppTheme.primaryTextColor,
    );
  }

  TextStyle description() {
    return Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(color: AppTheme.secondaryTextColor);
  }

  TextStyle regular() {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 16,
      color: AppTheme.primaryTextColor,
    );
  }

  /// Screen and section headings — Cormorant Garamond, as luxsav.com's
  /// `.tsoka-heading-*`.
  TextStyle heading({double fontSize = 28}) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: AppTheme.primaryTextColor,
    );
  }

  /// Product names on cards — `.tsoka-activity-card__name`, sized up slightly
  /// because Cormorant sets small next to Inter.
  TextStyle cardName({double fontSize = 24}) {
    return heading(fontSize: fontSize);
  }

  /// Prices — `.tsoka-activity-card__price-value`.
  TextStyle price({double fontSize = 24}) {
    return heading(fontSize: fontSize).copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle bold() {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 14,
      color: AppTheme.primaryTextColor,
    );
  }
}
