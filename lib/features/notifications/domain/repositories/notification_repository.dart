import 'package:injectable/injectable.dart';
import '../models/notification_model.dart';
import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotifications();
}

@LazySingleton(as: NotificationRepository)
class MockNotificationRepository implements NotificationRepository {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    final now = DateTime.now();

    return [
      NotificationModel(
        id: '1',
        title: 'Welcome to Gonana!',
        body: 'Thanks for joining our community of farmers and buyers.',
        timestamp: now.subtract(const Duration(days: 2)),
        isRead: false,
        type: NotificationType.system,
      ),
      NotificationModel(
        id: '2',
        title: 'Order Shipped',
        body: 'Your order #12345 has been shipped and is on its way.',
        timestamp: now.subtract(const Duration(hours: 5)),
        isRead: false,
        type: NotificationType.order,
        actionUrl: '/orders/12345',
      ),
      NotificationModel(
        id: '3',
        title: 'New Feature Alert',
        body: 'Check out the new Savings feature to grow your wealth.',
        timestamp: now.subtract(const Duration(days: 1)),
        isRead: true,
        type: NotificationType.system,
        actionUrl: '/wallet/savings',
      ),
      NotificationModel(
        id: '4',
        title: 'Security Update',
        body: 'We have updated our terms of service. Please review them.',
        timestamp: now.subtract(const Duration(days: 5)),
        isRead: true,
        type: NotificationType.system,
      ),
      NotificationModel(
        id: '5',
        title: 'Wallet Credited',
        body: 'Your wallet has been credited with NGN 5,000.',
        timestamp: now.subtract(const Duration(hours: 12)),
        isRead: false,
        type: NotificationType.wallet,
        actionUrl: '/wallet',
      ),
      NotificationModel(
        id: '6',
        title: 'New Comment on Your Post',
        body: 'John Doe commented on your farming tips post.',
        timestamp: now.subtract(const Duration(hours: 3)),
        isRead: false,
        type: NotificationType.feed,
        actionUrl: '/feed/post/123',
      ),
    ];
  }
}
