import 'package:flutter/material.dart';

enum LogoAlignment { horizontal, vertical }

class AppLogo extends StatelessWidget {
  final double? size;
  final String? title;
  final LogoAlignment alignment;
  final double spacing;
  final bool showIcon;
  final bool showText;

  const AppLogo({
    super.key,
    this.size = 20,
    this.title,
    this.alignment = LogoAlignment.horizontal,
    this.spacing = 10,
    this.showIcon = true,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withAlpha(200),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(50),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(
        Icons.health_and_safety_rounded,
        color: Colors.white,
        size: (size! - (size! * 0.1)).toDouble(),
      ),
    );

    final textWidget = Text.rich(
      TextSpan(
        children: [
          if (title == null && showText)
            TextSpan(
              text: "Health",
              style: TextStyle(
                fontSize: size! - 2.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          if (title == null && showText)
            TextSpan(
              text: "Cure",
              style: TextStyle(
                fontSize: size! - 2.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          if (title != null && showText)
            TextSpan(
              text: title!,
              style: TextStyle(
                fontSize: size! - 2.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
                letterSpacing: 0.5,
              ),
            ),
        ],
      ),
    );

    if (alignment == LogoAlignment.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) iconWidget,
          if (showIcon && showText) SizedBox(height: spacing),
          if (showText) textWidget,
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showIcon) iconWidget,
        if (showIcon && showText) SizedBox(width: spacing),
        if (showText) textWidget,
      ],
    );
  }
}
