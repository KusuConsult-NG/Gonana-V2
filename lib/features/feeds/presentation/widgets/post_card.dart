import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onLike;
  final VoidCallback? onReply;
  final VoidCallback? onRepost;
  final VoidCallback? onDelete;

  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onReply,
    this.onRepost,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassContainer(
      padding: const EdgeInsets.all(16.0),
      borderRadius: BorderRadius.circular(20),
      opacity: 0.6,
      blur: 15,
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with larger avatar
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xff22c55e), Color(0xff16a34a)],
                  ),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: isDark ? Colors.black : Colors.white,
                  backgroundImage: post.ownerPhoto != null
                      ? CachedNetworkImageProvider(post.ownerPhoto!)
                      : null,
                  child: post.ownerPhoto == null
                      ? const Icon(Icons.person, size: 24)
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.ownerName ?? 'Unknown User',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      _formatTimestamp(post.createdAt ?? DateTime.now()),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isDark
                            ? const Color(0xff9ca3af)
                            : const Color(0xff6b7280),
                      ),
                    ),
                  ],
                ),
              ),
              if (onDelete != null)
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') onDelete?.call();
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text('Delete Post'),
                        ],
                      ),
                    ),
                  ],
                  icon: Icon(
                    Icons.more_vert,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Content
          if (post.body != null && post.body!.isNotEmpty) ...[
            Text(
              post.body!,
              style: GoogleFonts.inter(
                fontSize: 15,
                height: 1.5,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
          ],
          // Images with better loading
          if (post.images.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: post.images.first,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 220,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 220,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          // Modern action buttons
          Row(
            children: [
              _ActionButton(
                icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                label: _formatCount(post.likesCount),
                color: post.isLiked ? Colors.red : Colors.grey,
                onTap: onLike,
              ),
              const SizedBox(width: 20),
              _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: _formatCount(post.commentsCount),
                color: Colors.grey,
                onTap: onReply,
              ),
              const SizedBox(width: 20),
              _ActionButton(
                icon: Icons.repeat,
                label: '',
                color: Colors.grey,
                onTap: onRepost,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.share_outlined, size: 22),
                color: Colors.grey,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(timestamp);
    }
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
