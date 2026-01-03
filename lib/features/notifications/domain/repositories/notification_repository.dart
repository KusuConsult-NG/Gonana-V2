import 'package:injectable/injectable.dart';
import '../models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotifications();
}

@LazySingleton(as: NotificationRepository)
class MockNotificationRepository implements NotificationRepository {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    return [
      NotificationModel(
        id: '1',
        title: 'Welcome to Gonana!',
        body: 'Thanks for joining our community of farmers and buyers.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NotificationModel(
        id: '2',
        title: 'Order Shipped',
        body: 'Your order #12345 has been shipped and is on its way.',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      NotificationModel(
        id: '3',
        title: 'New Feature Alert',
        body: 'Check out the new Savings feature to grow your wealth.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationModel(
        id: '4',
        title: 'Security Update',
        body: 'We have updated our terms of service. Please review them.',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }
}
