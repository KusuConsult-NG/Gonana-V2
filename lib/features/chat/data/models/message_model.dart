import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/message_entity.dart';
import 'chat_model.dart'; // For TimestampConverter

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.text,
    @TimestampConverter() required super.timestamp,
    super.isRead,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
