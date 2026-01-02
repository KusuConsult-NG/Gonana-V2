import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/message_entity.dart';

part 'chat_detail_state.freezed.dart';

@freezed
class ChatDetailState with _$ChatDetailState {
  const factory ChatDetailState.initial() = _Initial;
  const factory ChatDetailState.loading() = _Loading;
  const factory ChatDetailState.loaded(List<MessageEntity> messages) = _Loaded;
  const factory ChatDetailState.sending() =
      _Sending; // Optional: for UI feedback
  const factory ChatDetailState.error(String message) = _Error;
}
