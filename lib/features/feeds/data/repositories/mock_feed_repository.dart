import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/feed_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

// @LazySingleton(as: FeedRepository)
@LazySingleton(as: FeedRepository)
class MockFeedRepository implements FeedRepository {
  List<PostModel> _posts = [
    PostModel(
      id: '1',
      ownerId: 'user1',
      ownerName: 'Musa Aliyu',
      body:
          'Just harvested 500 bags of maize! DM for bulk orders. #Farming #Harvest',
      images: [
        'https://images.unsplash.com/photo-1625246333195-098e47970d73?w=800',
      ],
      likesCount: 15,
      commentsCount: 2,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likedBy: [],
    ),
    PostModel(
      id: '2',
      ownerId: 'user2',
      ownerName: 'Grace Okafor',
      body:
          'Looking for reliable logistics partners for my yam tubers from Benue to Lagos.',
      images: [],
      likesCount: 5,
      commentsCount: 0,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      likedBy: ['user1'],
    ),
    PostModel(
      id: '3',
      ownerId: 'user3',
      ownerName: 'Ibrahim Sani',
      body:
          'New sustainable irrigation techniques I tried today. Check these results! 💧🌱',
      images: [
        'https://images.unsplash.com/photo-1599593922312-e64e5c80525d?w=800',
      ],
      likesCount: 42,
      commentsCount: 8,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      likedBy: ['user1', 'user2'],
    ),
  ];

  final Map<String, List<CommentModel>> _comments = {
    '1': [
      CommentModel(
        id: 'c1',
        postId: '1',
        userId: 'user2',
        userName: 'Grace Okafor',
        text: 'Congratulations! What is the price per bag?',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      CommentModel(
        id: 'c2',
        postId: '1',
        userId: 'user1',
        userName: 'Musa Aliyu',
        text: '35,000 NGN per bag. Discount for >100 bags.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
    ],
    '3': [
      CommentModel(
        id: 'c3',
        postId: '3',
        userId: 'user2',
        userName: 'Grace Okafor',
        text: 'This looks amazing!',
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
    ],
  };

  @override
  Future<Either<String, FeedEntity>> getFeed() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Right(FeedEntity(posts: _posts, stories: []));
  }

  @override
  Future<Either<String, void>> likePost(String postId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index == -1) return Left('Post not found');

    final post = _posts[index];
    final isLiked = post.likedBy.contains(userId);

    List<String> newLikedBy = List.from(post.likedBy ?? []);
    int newLikesCount = post.likesCount;

    if (isLiked) {
      newLikedBy.remove(userId);
      newLikesCount--;
    } else {
      newLikedBy.add(userId);
      newLikesCount++;
    }

    _posts[index] = post.copyWith(
      likedBy: newLikedBy,
      likesCount: newLikesCount,
    );
    return const Right(null);
  }

  @override
  Future<void> createPost({required String caption, File? image}) async {
    await Future.delayed(const Duration(seconds: 1));
    final newPost = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      ownerId: 'mock_current_user',
      ownerName: 'Me',
      body: caption,
      images: image != null
          ? [
              'https://images.unsplash.com/photo-1625246333195-098e47970d73?w=800',
            ]
          : [],
      likesCount: 0,
      commentsCount: 0,
      createdAt: DateTime.now(),
      likedBy: [],
    );
    _posts.insert(0, newPost);
  }

  @override
  Future<Either<String, void>> commentOnPost(
    String postId,
    String comment,
    String userId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: postId,
      userId: userId,
      userName: 'Me',
      text: comment,
      createdAt: DateTime.now(),
    );

    if (_comments.containsKey(postId)) {
      _comments[postId]!.add(newComment);
    } else {
      _comments[postId] = [newComment];
    }

    // Update post comment count
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(commentsCount: post.commentsCount + 1);
    }

    return const Right(null);
  }

  @override
  Future<Either<String, List<CommentEntity>>> getComments(String postId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final models = _comments[postId] ?? [];
    // Convert to Entity
    final entities = models.map((m) => m.toEntity()).toList();
    return Right(entities);
  }

  @override
  Future<Either<String, void>> deletePost(String postId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _posts.removeWhere((p) => p.id == postId);
    return const Right(null);
  }
}
