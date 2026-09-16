import 'package:flutter/material.dart';
import 'package:luxsav_companion/widgets/tap_effect.dart';
import 'package:luxsav_companion/constants/luxsav_brand.dart';
import 'package:luxsav_companion/constants/text_styles.dart';
import 'package:luxsav_companion/constants/themes.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String? buttonText;
  final Widget? buttonTextWidget;
  final Color? textColor, backgroundColor;
  final bool? isClickable;

  /// Secondary style: transparent with a green outline (`.tsoka-btn--outline`).
  final bool isOutlined;
  final double radius;
  const CommonButton({
    Key? key,
    this.onTap,
    this.buttonText,
    this.buttonTextWidget,
    this.textColor,
    this.backgroundColor,
    this.padding,
    this.isClickable = true,
    this.radius = LuxRadius.control,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(),
      child: TapEffect(
        isClickable: isClickable!,
        onClick: onTap ?? () {},
        child: SizedBox(
          height: 48,
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: isOutlined
                  ? BorderSide(color: Theme.of(context).primaryColor)
                  : BorderSide.none,
            ),
            color: isOutlined
                ? Colors.transparent
                : backgroundColor ?? Theme.of(context).primaryColor,
            child: Center(
              child:
                  buttonTextWidget ??
                  Text(
                    // luxsav.com buttons: uppercase, medium weight, 0.15em tracking.
                    (buttonText ?? "").toUpperCase(),
                    style: TextStyles(context).regular().copyWith(
                      // Default follows the theme: white on green (light),
                      // charcoal on gold (dark) — white on gold fails contrast.
                      color:
                          textColor ??
                          (isOutlined
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).colorScheme.onPrimary),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.1,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
