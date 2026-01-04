import 'package:flutter/material.dart';

/// Modern custom card matching HTML design aesthetics
/// Features clean borders, soft shadows, and responsive hover states
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double borderRadius;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;
  final bool isElevated;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius = 12,
    this.shadows,
    this.onTap,
    this.isElevated = false,
  });

  /// Card with border (default style from HTML designs)
  factory CustomCard.bordered({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? borderColor,
    double borderRadius = 12,
    VoidCallback? onTap,
  }) {
    return CustomCard(
      padding: padding,
      margin: margin,
      borderColor: borderColor,
      borderWidth: 1,
      borderRadius: borderRadius,
      onTap: onTap,
      child: child,
    );
  }

  /// Card with elevation/shadow
  factory CustomCard.elevated({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double borderRadius = 12,
    VoidCallback? onTap,
  }) {
    return CustomCard(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      onTap: onTap,
      isElevated: true,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark ? const Color(0xff1f2937) : const Color(0xffffffff));

    final bColor =
        borderColor ??
        (isDark ? const Color(0xff374151) : const Color(0xffe5e7eb));

    final cardShadows =
        shadows ??
        (isElevated
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null);

    Widget card = Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: borderWidth != null
            ? Border.all(color: bColor, width: borderWidth!)
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: cardShadows,
      ),
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: card,
        ),
      );
    }

    return card;
  }
}
