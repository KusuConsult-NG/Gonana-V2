import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe
              ? AppTheme.primaryColor
              : (isDark ? const Color(0xff374151) : Colors.grey[200]),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                color: isMe
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black87),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
              style: GoogleFonts.inter(
                color: isMe
                    ? Colors.white.withValues(alpha: 0.7)
                    : (isDark ? Colors.grey[400] : Colors.black54),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
