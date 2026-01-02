import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/feed_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FirebaseFirestore _firestore;

  FeedRepositoryImpl(this._firestore);

  @override
  Future<Either<String, FeedEntity>> getFeed() async {
    // Return MOCK DATA directly as per user request to populate feeds
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay

    final mockStories = [
      StoryModel(
        id: '1',
        ownerName: 'CryptoKing',
        imageUrl: 'https://i.pravatar.cc/150?u=1',
        ownerPhoto: 'https://i.pravatar.cc/150?u=1',
        isViewed: false,
      ),
      StoryModel(
        id: '2',
        ownerName: 'FarmLead',
        imageUrl: 'https://i.pravatar.cc/150?u=2',
        ownerPhoto: 'https://i.pravatar.cc/150?u=2',
        isViewed: false,
      ),
      StoryModel(
        id: '3',
        ownerName: 'GonanaOfficial',
        imageUrl: 'https://i.pravatar.cc/150?u=3',
        ownerPhoto: 'https://i.pravatar.cc/150?u=3',
        isViewed: true,
      ),
    ];

    final mockPosts = [
      PostModel(
        id: '1',
        ownerId: 'u3',
        ownerName: 'Gonana Official',
        ownerPhoto: 'https://i.pravatar.cc/150?u=3',
        body:
            'Welcome to the future of agriculture! 🌾 Gonana Enhanced is live. #Gonana #AgriTech',
        images: [
          'https://images.unsplash.com/photo-1625246333195-bf3fbc24458d?w=800&q=80',
        ],
        createdAt: DateTime.now(),
        likesCount: 124,
        commentsCount: 45,
      ),
      PostModel(
        id: '2',
        ownerId: 'u1',
        ownerName: 'CryptoKing',
        ownerPhoto: 'https://i.pravatar.cc/150?u=1',
        body: 'Just staked my first batch of tokens. The APY looks amazing! 🚀',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        likesCount: 89,
        commentsCount: 12,
      ),
      PostModel(
        id: '3',
        ownerId: 'u2',
        ownerName: 'FarmLead',
        ownerPhoto: 'https://i.pravatar.cc/150?u=2',
        body:
            'Harvest season is approaching. Make sure to list your produce early on the market.',
        images: [
          'https://images.unsplash.com/photo-1500937386664-56d1dfef3854?w=800&q=80',
        ],
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        likesCount: 256,
        commentsCount: 67,
      ),
    ];

    return Right(FeedEntity(posts: mockPosts, stories: mockStories));
  }

  @override
  Future<Either<String, void>> likePost(String postId) async {
    try {
      // Optimization: In a real app, use a batch write or transaction
      // to update user's liked posts subcollection AND the post's like count.
      await _firestore.collection('posts').doc(postId).update({
        'likesCount': FieldValue.increment(1),
      });
      return const Right(null);
    } catch (e) {
      return Left('Failed to like post: $e');
    }
  }

  @override
  Future<Either<String, void>> commentOnPost(
    String postId,
    String comment,
  ) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add({
            'body': comment,
            'createdAt': FieldValue.serverTimestamp(),
            // 'ownerId': currentUserId... need auth for this.
          });
      return const Right(null);
    } catch (e) {
      return Left('Failed to comment: $e');
    }
  }
}
