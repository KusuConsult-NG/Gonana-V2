import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/message_entity.dart';

part 'chat_detail_event.freezed.dart';

@freezed
class ChatDetailEvent with _$ChatDetailEvent {
  const factory ChatDetailEvent.started(String chatId) = _Started;
  const factory ChatDetailEvent.messagesUpdated(List<MessageEntity> messages) =
      _MessagesUpdated;
  const factory ChatDetailEvent.sendMessage(String text) = _SendMessage;
}
