import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String otherUserName; // Helper for UI
  final String otherUserPhoto; // Helper for UI

  const ChatEntity({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    this.otherUserName = '',
    this.otherUserPhoto = '',
  });

  @override
  List<Object?> get props => [
    id,
    participants,
    lastMessage,
    lastMessageTime,
    otherUserName,
    otherUserPhoto,
  ];
}
