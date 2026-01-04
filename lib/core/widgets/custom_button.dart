import 'package:flutter/material.dart';

/// Modern custom buttons matching HTML design
/// Primary, Secondary, and Outline variants
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final ButtonStyle? style;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 8,
    this.style,
  });

  /// Primary button (vibrant green background)
  factory CustomButton.primary({
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return CustomButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      backgroundColor: const Color(0xff22c55e),
      foregroundColor: Colors.white,
    );
  }

  /// Secondary button (darker green background)
  factory CustomButton.secondary({
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return CustomButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      backgroundColor: const Color(0xff15803d),
      foregroundColor: Colors.white,
    );
  }

  /// Outline button (transparent with green border)
  factory CustomButton.outline({
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return CustomButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xff22c55e),
        side: const BorderSide(color: Color(0xff22c55e), width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }

  /// Text button (no background, just text)
  factory CustomButton.text({
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
  }) {
    return CustomButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      style: TextButton.styleFrom(foregroundColor: const Color(0xff22c55e)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle =
        style ??
        ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );

    Widget button;

    if (style != null && style.toString().contains('OutlinedButton')) {
      button = OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: _buildContent(context),
      );
    } else if (style != null && style.toString().contains('TextButton')) {
      button = TextButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: _buildContent(context),
      );
    } else {
      button = ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: _buildContent(context),
      );
    }

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 18), const SizedBox(width: 8), Text(label)],
      );
    }

    return Text(label);
  }
}
