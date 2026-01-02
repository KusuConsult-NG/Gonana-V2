import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/chat_entity.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel extends ChatEntity {
  const ChatModel({
    required super.id,
    required super.participants,
    required super.lastMessage,
    @TimestampConverter() required super.lastMessageTime,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel.fromJson(data..['id'] = doc.id);
  }

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
