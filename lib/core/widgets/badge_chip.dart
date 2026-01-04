import 'package:flutter/material.dart';

/// Modern badge chip matching HTML design
/// Used for status indicators, categories, and tags
class BadgeChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isOutlined;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const BadgeChip({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isOutlined = false,
    this.onTap,
    this.padding,
  });

  // Predefined badge styles matching HTML designs
  factory BadgeChip.success({
    required String label,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return BadgeChip(
      label: label,
      backgroundColor: const Color(0xfff0fdf4),
      textColor: const Color(0xff16a34a),
      icon: icon,
      onTap: onTap,
    );
  }

  factory BadgeChip.warning({
    required String label,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return BadgeChip(
      label: label,
      backgroundColor: const Color(0xfffef3c7),
      textColor: const Color(0xffd97706),
      icon: icon,
      onTap: onTap,
    );
  }

  factory BadgeChip.error({
    required String label,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return BadgeChip(
      label: label,
      backgroundColor: const Color(0xfffee2e2),
      textColor: const Color(0xffdc2626),
      icon: icon,
      onTap: onTap,
    );
  }

  factory BadgeChip.info({
    required String label,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return BadgeChip(
      label: label,
      backgroundColor: const Color(0xffdbeafe),
      textColor: const Color(0xff2563eb),
      icon: icon,
      onTap: onTap,
    );
  }

  factory BadgeChip.primary({
    required String label,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return BadgeChip(
      label: label,
      backgroundColor: const Color(0xfff0fdf4),
      textColor: const Color(0xff22c55e),
      icon: icon,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark ? const Color(0xff374151) : const Color(0xfff3f4f6));
    final fgColor =
        textColor ??
        (isDark ? const Color(0xfff3f4f6) : const Color(0xff111827));

    Widget child = Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : bgColor,
        border: isOutlined ? Border.all(color: fgColor, width: 1.5) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fgColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: fgColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      child = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: child,
      );
    }

    return child;
  }
}
