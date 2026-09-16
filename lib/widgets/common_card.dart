import 'package:flutter/material.dart';
import 'package:luxsav_companion/constants/themes.dart';

class CommonCard extends StatefulWidget {
  final Color? color;
  final double radius;
  final Widget? child;

  const CommonCard({Key? key, this.color, this.radius = 16, this.child})
    : super(key: key);
  @override
  State<CommonCard> createState() => _CommonCardState();
}

class _CommonCardState extends State<CommonCard> {
  @override
  Widget build(BuildContext context) {
    // Flat with a hairline edge, like luxsav.com cards — no drop shadow.
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: widget.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius),
        side: BorderSide(color: AppTheme.cardBorderColor),
      ),
      child: widget.child,
    );
  }
}
