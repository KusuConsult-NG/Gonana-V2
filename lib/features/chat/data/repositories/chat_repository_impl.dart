import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatRepositoryImpl(this._firestore, this._auth);

  @override
  Stream<List<ChatEntity>> getChats() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection('chats')
        .where('participants', arrayContains: uid)
        // .orderBy('lastMessageTime', descending: true) // REMOVED to fix crash without Index
        .snapshots()
        .map((snapshot) {
          final chats = snapshot.docs
              .map((doc) => ChatModel.fromFirestore(doc))
              .toList();
          // Sort locally instead
          chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
          return chats;
        });
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromFirestore(doc))
              .toList();
        });
  }

  @override
  Future<Either<String, void>> sendMessage(String chatId, String text) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Left('User not logged in');

    try {
      final now = DateTime.now();
      final messageData = {
        'senderId': uid,
        'text': text,
        'timestamp': Timestamp.fromDate(now),
        'isRead': false,
      };

      // Batch write to update message collection and chat lastMessage
      final batch = _firestore.batch();
      final messageRef = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc();
      final chatRef = _firestore.collection('chats').doc(chatId);

      batch.set(messageRef, messageData);
      batch.update(chatRef, {
        'lastMessage': text,
        'lastMessageTime': Timestamp.fromDate(now),
      });

      await batch.commit();
      return const Right(null);
    } catch (e) {
      return Left('Failed to send message: $e');
    }
  }

  @override
  Future<Either<String, String>> createChat(String otherUserId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Left('User not logged in');

    try {
      // Check if chat already exists
      final querySnapshot = await _firestore
          .collection('chats')
          .where('participants', arrayContains: uid)
          .get();

      // Filter locally for exact pair match (Firestore limitation)
      for (var doc in querySnapshot.docs) {
        final participants = List<String>.from(doc['participants']);
        if (participants.contains(otherUserId)) {
          return Right(doc.id);
        }
      }

      // Create new chat
      final docRef = await _firestore.collection('chats').add({
        'participants': [uid, otherUserId],
        'lastMessage': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
      });

      return Right(docRef.id);
    } catch (e) {
      return Left('Failed to create chat: $e');
    }
  }
}
