import 'package:equatable/equatable.dart';

/// Notification type enum for categorization
enum NotificationType { order, wallet, feed, system }

/// Notification entity with read status and type
class NotificationEntity extends Equatable {
  final String? id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool? isRead;
  final NotificationType? type;
  final String? actionUrl; // For deep linking

  const NotificationEntity({
    this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
    this.type = NotificationType.system,
    this.actionUrl,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    body,
    timestamp,
    isRead,
    type,
    actionUrl,
  ];
}
