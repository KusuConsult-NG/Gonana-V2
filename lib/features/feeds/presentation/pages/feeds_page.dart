import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../widgets/post_card.dart';
import '../widgets/story_avatar.dart';
import '../widgets/comment_bottom_sheet.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class FeedsPage extends StatelessWidget {
  const FeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FeedsView();
  }
}

class _FeedsView extends StatelessWidget {
  const _FeedsView();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Feeds',
          style: GoogleFonts.montserrat(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.1),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_box_outlined,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
            ),
            onPressed: () => context.push('/create-post'),
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text('Error: $message')),
              loaded: (feed) => RefreshIndicator(
                onRefresh: () async {
                  context.read<FeedBloc>().add(const FeedEvent.refreshed());
                },
                child: CustomScrollView(
                  slivers: [
                    // Stories Section
                    SliverToBoxAdapter(
                      child: FadeInDown(
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          height: 110,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            itemCount:
                                feed.stories.length + 1, // +1 for "My Story"
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return _buildMyStoryAdd(context);
                              }
                              return StoryAvatar(
                                story: feed.stories[index - 1],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    // Posts Section
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return FadeInUp(
                          duration: const Duration(milliseconds: 600),
                          delay: Duration(milliseconds: 100 * index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: PostCard(
                              post: feed.posts[index],
                              onLike: () {
                                final authState = context
                                    .read<AuthBloc>()
                                    .state;
                                final userId = authState.maybeWhen(
                                  authenticated: (auth) => auth.user.id,
                                  orElse: () => null,
                                );
                                if (userId != null &&
                                    feed.posts[index].id != null) {
                                  context.read<FeedBloc>().add(
                                    FeedEvent.postLiked(
                                      feed.posts[index].id!,
                                      userId,
                                    ),
                                  );
                                }
                              },
                              onReply: () {
                                final post = feed.posts[index];
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) =>
                                      DraggableScrollableSheet(
                                        initialChildSize: 0.7,
                                        minChildSize: 0.5,
                                        maxChildSize: 0.95,
                                        builder: (_, scrollController) =>
                                            CommentBottomSheet(post: post),
                                      ),
                                );
                              },
                              onRepost: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Reposted (Mock)'),
                                  ),
                                );
                              },
                              onDelete: () {
                                if (feed.posts[index].id != null) {
                                  context.read<FeedBloc>().add(
                                    FeedEvent.postDeleted(
                                      feed.posts[index].id!,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      }, childCount: feed.posts.length),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMyStoryAdd(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300?u=me',
                  ), // Placeholder
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF29844B),
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.white, width: 2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, size: 14, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'My Story',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentDialog(BuildContext context, String postId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Comment',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Write a comment...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final authState = context.read<AuthBloc>().state;
              final userId = authState.maybeWhen(
                authenticated: (auth) => auth.user.id,
                orElse: () => null,
              );

              if (userId != null && controller.text.isNotEmpty) {
                context.read<FeedBloc>().add(
                  FeedEvent.postCommented(postId, controller.text, userId),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}

// Extension to help with blur property which is not standard in BoxDecoration
// But I used it above in local widget? No wait, BoxDecoration doesn't have blur.
// I should use MaskFilter or just ignore that property in standard Container.
// I will just remove 'blur: 60' from BoxDecoration in the code above to avoid error.
// Actually I can just use BoxShadow to fake the glow ball.
