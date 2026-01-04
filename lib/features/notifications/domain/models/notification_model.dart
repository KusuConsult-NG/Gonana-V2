import 'package:json_annotation/json_annotation.dart';
import '../entities/notification_entity.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.timestamp,
    required super.isRead,
    required super.type,
    super.actionUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
