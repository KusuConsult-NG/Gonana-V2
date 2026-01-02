import 'package:dartz/dartz.dart';
import '../entities/feed_entity.dart';

abstract class FeedRepository {
  Future<Either<String, FeedEntity>> getFeed();
  Future<Either<String, void>> likePost(String postId);
  Future<Either<String, void>> commentOnPost(String postId, String comment);
}
