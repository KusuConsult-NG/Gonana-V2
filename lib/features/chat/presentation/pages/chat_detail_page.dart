import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../config/injection.dart';
import '../bloc/chat_detail_bloc.dart';
import '../bloc/chat_detail_event.dart';
import '../bloc/chat_detail_state.dart';
import '../widgets/chat_bubble.dart';

class ChatDetailPage extends StatefulWidget {
  final String chatId;

  const ChatDetailPage({super.key, required this.chatId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Current user ID for determining "isMe"
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return BlocProvider(
      create: (context) =>
          getIt<ChatDetailBloc>()..add(ChatDetailEvent.started(widget.chatId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat'), // In real app, pass dynamic name
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (message) => Center(child: Text('Error: $message')),
                    loaded: (messages) {
                      if (messages.isEmpty) {
                        return const Center(
                          child: Text('No messages yet. Say hi!'),
                        );
                      }
                      return ListView.builder(
                        reverse: true, // Show latest at bottom
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return ChatBubble(
                            text: message.text,
                            isMe: message.senderId == currentUserId,
                            timestamp: message.timestamp,
                          );
                        },
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
            _buildInputArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isNotEmpty) {
                context.read<ChatDetailBloc>().add(
                  ChatDetailEvent.sendMessage(text),
                );
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
