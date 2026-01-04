import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/notification_entity.dart';

/// Modern notification card with icon, timestamp, and swipe actions
class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onMarkAsRead;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
    this.onDelete,
    this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRead = notification.isRead ?? true;

    return Dismissible(
      key: Key(notification.id ?? DateTime.now().toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete?.call();
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: InkWell(
        onTap: () {
          if (!isRead) {
            onMarkAsRead?.call();
          }
          onTap?.call();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isRead
                ? (isDark ? const Color(0xff1f2937) : Colors.white)
                : (isDark
                      ? const Color(0xff1f2937).withValues(alpha: 0.8)
                      : const Color(0xff22c55e).withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isRead
                  ? (isDark ? const Color(0xff374151) : const Color(0xffe5e7eb))
                  : const Color(0xff22c55e).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getTypeColor(notification.type).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getTypeIcon(notification.type),
                  color: _getTypeColor(notification.type),
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: isRead
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xff22c55e),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: isDark
                            ? const Color(0xff9ca3af)
                            : const Color(0xff6b7280),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatTimestamp(notification.timestamp),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isDark
                            ? const Color(0xff6b7280)
                            : const Color(0xff9ca3af),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon(NotificationType? type) {
    switch (type) {
      case NotificationType.order:
        return Icons.shopping_bag_outlined;
      case NotificationType.wallet:
        return Icons.account_balance_wallet_outlined;
      case NotificationType.feed:
        return Icons.forum_outlined;
      case NotificationType.system:
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getTypeColor(NotificationType? type) {
    switch (type) {
      case NotificationType.order:
        return const Color(0xff3b82f6); // Blue
      case NotificationType.wallet:
        return const Color(0xff22c55e); // Green
      case NotificationType.feed:
        return const Color(0xfff59e0b); // Amber
      case NotificationType.system:
      default:
        return const Color(0xff6366f1); // Indigo
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(timestamp);
    }
  }
}
