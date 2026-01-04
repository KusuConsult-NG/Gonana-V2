// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool?,
      type: $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']),
      actionUrl: json['actionUrl'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'timestamp': instance.timestamp.toIso8601String(),
      'isRead': instance.isRead,
      'type': _$NotificationTypeEnumMap[instance.type],
      'actionUrl': instance.actionUrl,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.order: 'order',
  NotificationType.wallet: 'wallet',
  NotificationType.feed: 'feed',
  NotificationType.system: 'system',
};
