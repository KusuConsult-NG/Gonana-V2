import 'package:dartz/dartz.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Stream<List<ChatEntity>> getChats();
  Stream<List<MessageEntity>> getMessages(String chatId);
  Future<Either<String, void>> sendMessage(String chatId, String text);
  Future<Either<String, String>> createChat(String otherUserId);
}
