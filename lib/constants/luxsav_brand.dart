import 'package:flutter/material.dart';

/// LuxSav brand colours, copied from the luxsav.com stylesheet
/// (`public/css/tsoka/tsoka.css`, `:root`). The website is the source of truth:
/// change a value there first, then here.
class LuxColors {
  LuxColors._();

  /// `--lux-primary`. Primary buttons, selected tab, key headers.
  static const green = Color(0xFF1F4D3A);

  /// `--lux-primary-hover`. Pressed states.
  static const greenHover = Color(0xFF2E6B53);

  /// `--tsoka-gold`. The accent — only on dark surfaces, and to mark anything
  /// Tanova suggested. Too pale for text on light backgrounds.
  static const gold = Color(0xFFD6B87A);

  /// `--tsoka-gold-on-light`. Gold for text and icons on light backgrounds,
  /// where [gold] fails contrast (the site uses this for the same reason).
  static const goldOnLight = Color(0xFF7A5C28);

  /// `--tsoka-ivory`. App background.
  static const ivory = Color(0xFFF6F5F1);

  /// `--tsoka-cream`. Section and alternate card backgrounds.
  static const cream = Color(0xFFEAE7E0);

  /// `--tsoka-charcoal`. Text.
  static const charcoal = Color(0xFF1C1C1C);

  /// `--lux-border`. Hairline borders.
  static const border = Color(0xFFD9D9D9);

  static const white = Color(0xFFFFFFFF);

  /// Muted text on light backgrounds (5:1 on [ivory]).
  static const mutedOnLight = Color(0xFF6B6A64);

  // luxsav.com has no dark mode. These are derived from the brand so the
  // app's existing dark mode stays usable; they need design sign-off.
  static const darkSurface = Color(0xFF262624);
  static const darkBorder = Color(0xFF3A3A36);
  static const mutedOnDark = Color(0xFFA3A19A);
}

/// Corner radii, from luxsav.com (`--radius-*` and `.tsoka-btn`).
class LuxRadius {
  LuxRadius._();

  /// Buttons and text inputs (`.tsoka-btn` uses 6px).
  static const double control = 6;

  /// Small surfaces: chips, thumbnails (`--radius-md`).
  static const double small = 8;

  /// Cards and sheets (`--radius-lg`).
  static const double card = 16;
}
