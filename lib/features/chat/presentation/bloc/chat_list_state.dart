import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/chat_entity.dart';

part 'chat_list_state.freezed.dart';

@freezed
class ChatListState with _$ChatListState {
  const factory ChatListState.initial() = _Initial;
  const factory ChatListState.loading() = _Loading;
  const factory ChatListState.loaded(List<ChatEntity> chats) = _Loaded;
  const factory ChatListState.error(String message) = _Error;
}
