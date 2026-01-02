import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../bloc/chat_list_bloc.dart';
import '../bloc/chat_list_event.dart';
import '../bloc/chat_list_state.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ChatListBloc>()..add(const ChatListEvent.started()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Chats')),
        body: BlocBuilder<ChatListBloc, ChatListState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text('Error: $message')),
              loaded: (chats) {
                if (chats.isEmpty) {
                  return const Center(child: Text('No active chats'));
                }
                return ListView.separated(
                  itemCount: chats.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    // Logic to show "Other User" name would typically involve fetching
                    // that user's profile if not embedded in chat.
                    // For now, we use the helper or a placeholder.
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(
                        chat.otherUserName.isNotEmpty
                            ? chat.otherUserName
                            : 'User',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        _formatTime(chat.lastMessageTime),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        context.push('/chat/${chat.id}');
                      },
                    );
                  },
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    // Simple helper (should use intl package in production)
    final now = DateTime.now();
    if (now.difference(time).inDays == 0) {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      return '${time.day}/${time.month}';
    }
  }
}
