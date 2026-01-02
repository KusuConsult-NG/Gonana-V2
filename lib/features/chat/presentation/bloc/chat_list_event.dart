import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/chat_entity.dart';

part 'chat_list_event.freezed.dart';

@freezed
class ChatListEvent with _$ChatListEvent {
  const factory ChatListEvent.started() = _Started;
  const factory ChatListEvent.chatsUpdated(List<ChatEntity> chats) =
      _ChatsUpdated;
}
