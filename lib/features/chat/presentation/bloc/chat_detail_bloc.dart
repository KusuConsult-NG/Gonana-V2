import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_detail_event.dart';
import 'chat_detail_state.dart';

@injectable
class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ChatRepository _repository;
  StreamSubscription? _messagesSubscription;
  String? _chatId;

  ChatDetailBloc(this._repository) : super(const ChatDetailState.initial()) {
    on<ChatDetailEvent>((event, emit) async {
      await event.map(
        started: (e) async {
          _chatId = e.chatId;
          emit(const ChatDetailState.loading());
          await _messagesSubscription?.cancel();
          _messagesSubscription = _repository
              .getMessages(e.chatId)
              .listen(
                (messages) => add(ChatDetailEvent.messagesUpdated(messages)),
                onError: (e) => emit(ChatDetailState.error(e.toString())),
              );
        },
        messagesUpdated: (e) async {
          emit(ChatDetailState.loaded(e.messages));
        },
        sendMessage: (e) async {
          if (_chatId == null) return;
          final result = await _repository.sendMessage(_chatId!, e.text);
          result.fold((l) => emit(ChatDetailState.error(l)), (r) {});
        },
      );
    });
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
