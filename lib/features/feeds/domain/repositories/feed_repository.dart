import 'package:dartz/dartz.dart';
import '../entities/feed_entity.dart';
import '../entities/comment_entity.dart';

import 'dart:io';

abstract class FeedRepository {
  Future<Either<String, FeedEntity>> getFeed();
  Future<Either<String, void>> likePost(String postId, String userId);
  Future<void> createPost({required String caption, File? image});
  Future<Either<String, void>> commentOnPost(
    String postId,
    String comment,
    String userId,
  );
  Future<Either<String, List<CommentEntity>>> getComments(String postId);
  Future<Either<String, void>> deletePost(String postId);
}
