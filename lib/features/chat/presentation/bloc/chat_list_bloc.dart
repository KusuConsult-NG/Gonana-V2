import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_list_event.dart';
import 'chat_list_state.dart';

@injectable
class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository _repository;
  StreamSubscription? _chatsSubscription;

  ChatListBloc(this._repository) : super(const ChatListState.initial()) {
    on<ChatListEvent>((event, emit) async {
      await event.map(
        started: (_) async {
          emit(const ChatListState.loading());
          await _chatsSubscription?.cancel();
          _chatsSubscription = _repository.getChats().listen(
            (chats) => add(ChatListEvent.chatsUpdated(chats)),
            onError: (e) => emit(ChatListState.error(e.toString())),
          );
        },
        chatsUpdated: (e) async {
          emit(ChatListState.loaded(e.chats));
        },
      );
    });
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
