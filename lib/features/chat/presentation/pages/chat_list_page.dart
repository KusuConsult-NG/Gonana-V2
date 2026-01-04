import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../bloc/chat_list_bloc.dart';
import '../bloc/chat_list_state.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            loaded: (chats) {
              if (chats.isEmpty) {
                return EmptyState(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'No messages yet',
                  message:
                      'Connect with sellers and buyers to start a conversation.',
                  actionLabel: 'Explore Market',
                  onActionPressed: () => context.go('/market'),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: chats.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return _buildChatTile(context, chat);
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, dynamic chat) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xff1f2937).withValues(alpha: 0.8)
            : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
          backgroundImage: chat.otherUserPhoto.isNotEmpty
              ? NetworkImage(chat.otherUserPhoto)
              : null,
          child: chat.otherUserPhoto.isEmpty
              ? Text(
                  chat.otherUserName.isNotEmpty
                      ? chat.otherUserName[0].toUpperCase()
                      : 'U',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                )
              : null,
        ),
        title: Text(
          chat.otherUserName.isNotEmpty ? chat.otherUserName : 'Unknown User',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            chat.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? const Color(0xff9ca3af) : const Color(0xff6b7280),
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatTime(chat.lastMessageTime),
              style: GoogleFonts.inter(
                fontSize: 12,
                color: isDark
                    ? const Color(0xff9ca3af)
                    : const Color(0xff6b7280),
                fontWeight: FontWeight.w500,
              ),
            ),
            // Unread indicator could go here if available
          ],
        ),
        onTap: () {
          context.push('/chat/${chat.id}');
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      // Weekday name
      const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return weekdays[time.weekday - 1];
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}
