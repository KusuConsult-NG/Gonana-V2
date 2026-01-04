import 'package:flutter/material.dart';

/// Profile avatar widget with verification badge support
/// Matches HTML design with circular avatars and optional verification icon
class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final bool isVerified;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool showBorder;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.isVerified = false,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            backgroundColor ??
            (isDark ? const Color(0xff374151) : const Color(0xfff3f4f6)),
        border: showBorder
            ? Border.all(
                color: isDark
                    ? const Color(0xff4b5563)
                    : const Color(0xffe5e7eb),
                width: 2,
              )
            : null,
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Text(
                initials ?? '?',
                style: TextStyle(
                  color:
                      textColor ??
                      (isDark
                          ? const Color(0xfff3f4f6)
                          : const Color(0xff111827)),
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );

    if (isVerified) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: size * 0.35,
              height: size * 0.35,
              decoration: BoxDecoration(
                color: const Color(0xff22c55e),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? const Color(0xff1f2937) : Colors.white,
                  width: 2,
                ),
              ),
              child: Icon(Icons.check, color: Colors.white, size: size * 0.22),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      avatar = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: avatar,
      );
    }

    return avatar;
  }
}
