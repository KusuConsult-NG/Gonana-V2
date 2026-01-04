import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) =>
          getIt<ChatDetailBloc>()..add(ChatDetailEvent.started(widget.chatId)),
      child: ScaffoldWithBackground(
        appBar: AppBar(
          title: Text(
            'Chat',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                        return Center(
                          child: Text(
                            'No messages yet. Say hi!',
                            style: GoogleFonts.inter(
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        reverse: true, // Show latest at bottom
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
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
            _buildInputArea(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context, bool isDark) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _controller,
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: GoogleFonts.inter(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 4,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20,
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
