import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onLike;
  final VoidCallback? onReply;
  final VoidCallback? onRepost;

  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onReply,
    this.onRepost,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16.0),
      borderRadius: BorderRadius.circular(20),
      opacity: 0.6,
      blur: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(
                backgroundImage: post.ownerPhoto != null
                    ? NetworkImage(post.ownerPhoto!)
                    : null,
                child: post.ownerPhoto == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.ownerName ?? 'Unknown User',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '2 hours ago', // Placeholder for now
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 12),
          // Content
          if (post.body != null) ...[
            Text(
              post.body!,
              style: GoogleFonts.montserrat(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 12),
          ],
          // Images
          if (post.images.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                post.images.first,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
          const SizedBox(height: 12),
          // Actions
          Row(
            children: [
              IconButton(
                icon: Icon(
                  post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: post.isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: onLike,
              ),
              Text(
                '${post.likesCount}',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                onPressed: onReply,
              ),
              Text(
                '${post.commentsCount}',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.repeat, color: Colors.grey),
                onPressed: onRepost,
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
