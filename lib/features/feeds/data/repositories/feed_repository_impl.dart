import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/feed_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';
import '../models/comment_model.dart';
import 'dart:io';

// @LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  FeedRepositoryImpl(this._firestore, this._storage, this._auth);

  @override
  Future<Either<String, FeedEntity>> getFeed() async {
    try {
      final postsSnapshot = await _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();

      final storiesSnapshot = await _firestore.collection('stories').get();

      final userId = _auth.currentUser?.uid;

      final posts = postsSnapshot.docs.map((doc) {
        final data = doc.data()..['id'] = doc.id;
        final likedBy = List<String>.from(data['likedBy'] ?? []);
        // Manually set isLiked based on current user (PostModel defaults false)
        final post = PostModel.fromJson(data);
        return post.copyWith(
          isLiked: userId != null && likedBy.contains(userId),
        );
      }).toList();

      final stories = storiesSnapshot.docs
          .map((doc) => StoryModel.fromJson(doc.data()..['id'] = doc.id))
          .toList();

      return Right(FeedEntity(posts: posts, stories: stories));
    } catch (e) {
      return Left('Failed to fetch feed: $e');
    }
  }

  @override
  Future<Either<String, void>> likePost(String postId, String userId) async {
    try {
      final postDoc = await _firestore.collection('posts').doc(postId).get();
      if (!postDoc.exists) return const Left('Post not found');

      final data = postDoc.data() as Map<String, dynamic>;
      final likedBy = List<String>.from(data['likedBy'] ?? []);
      final isCurrentlyLiked = likedBy.contains(userId);

      if (isCurrentlyLiked) {
        await _firestore.collection('posts').doc(postId).update({
          'likedBy': FieldValue.arrayRemove([userId]),
          'likesCount': FieldValue.increment(-1),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likedBy': FieldValue.arrayUnion([userId]),
          'likesCount': FieldValue.increment(1),
        });
      }
      return const Right(null);
    } catch (e) {
      return Left('Failed to like post: $e');
    }
  }

  @override
  Future<Either<String, void>> commentOnPost(
    String postId,
    String comment,
    String userId,
  ) async {
    try {
      // Fetch user profile for name and photo to add to comment
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userData = userDoc.data();

      final commentData = {
        'body': comment,
        'userId': userId,
        'userName': userData?['firstName'] ?? 'User',
        'userPhoto': userData?['profilePhoto'],
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add(commentData);

      // Increment comments count on post
      await _firestore.collection('posts').doc(postId).update({
        'commentsCount': FieldValue.increment(1),
      });

      return const Right(null);
    } catch (e) {
      return Left('Failed to comment: $e');
    }
  }

  @override
  Future<void> createPost({required String caption, File? image}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    String? imageUrl;

    if (image != null) {
      final ref = _storage
          .ref()
          .child('posts')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(image);
      imageUrl = await ref.getDownloadURL();
    }

    // Fetch user profile for name and photo
    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final userData = userDoc.data();

    final newPost = PostModel(
      id: '',
      ownerId: user.uid,
      ownerName: userData?['firstName'] ?? 'User',
      ownerPhoto: userData?['profilePhoto'],
      body: caption,
      images: imageUrl != null ? [imageUrl] : [],
      createdAt: DateTime.now(),
      likesCount: 0,
      commentsCount: 0,
    );

    await _firestore.collection('posts').add(newPost.toJson());
  }

  @override
  Future<Either<String, List<CommentEntity>>> getComments(String postId) async {
    try {
      final commentsSnapshot = await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: false)
          .get();

      final comments = commentsSnapshot.docs
          .map((doc) => CommentModel.fromFirestore(doc).toEntity())
          .toList();

      return Right(comments);
    } catch (e) {
      return Left('Failed to fetch comments: $e');
    }
  }

  @override
  Future<Either<String, void>> deletePost(String postId) async {
    return const Left('Delete not supported in Live mode yet');
  }
}
