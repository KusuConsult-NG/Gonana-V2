import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Consistent empty state widget with illustration, title, message, and optional CTA
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color:
                    (isDark ? const Color(0xff22c55e) : const Color(0xff22c55e))
                        .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 60, color: const Color(0xff22c55e)),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark
                    ? const Color(0xff9ca3af)
                    : const Color(0xff6b7280),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            // Action button
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onActionPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff22c55e),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  actionLabel!,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
