import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../widgets/post_card.dart';
import '../widgets/story_avatar.dart';

class FeedsPage extends StatelessWidget {
  const FeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FeedBloc>()..add(const FeedEvent.started()),
      child: const _FeedsView(),
    );
  }
}

class _FeedsView extends StatelessWidget {
  const _FeedsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Feeds',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white.withValues(alpha: 0.1),
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
            icon: const Icon(Icons.add_box_outlined, color: Colors.black87),
            onPressed: () => context.push('/create-post'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Animated Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE0F7FA), // Light Cyan
                  Color(0xFFE8F5E9), // Light Green
                  Color(0xFFF3E5F5), // Light Purple
                ],
              ),
            ),
          ),
          // Orbs
          Positioned(
            top: 50,
            right: -50,
            child: FadeIn(
              duration: const Duration(seconds: 2),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF29844B).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF29844B).withValues(alpha: 0.2),
                      blurRadius: 60,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: BlocBuilder<FeedBloc, FeedState>(
              builder: (context, state) {
                return state.when(
                  initial: () =>
                      const Center(child: CircularProgressIndicator()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
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
                                    feed.stories.length +
                                    1, // +1 for "My Story"
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
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
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
                                    // Mock: context.read<FeedBloc>().add(FeedEvent.likePost(feed.posts[index].id));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Liked (Mock)'),
                                      ),
                                    );
                                  },
                                  onReply: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Reply (Mock)'),
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
                                ),
                              ),
                            );
                          }, childCount: feed.posts.length),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
              color: Colors.black87,
            ),
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
