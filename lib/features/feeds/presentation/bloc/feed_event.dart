import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:io';

part 'feed_event.freezed.dart';

@freezed
class FeedEvent with _$FeedEvent {
  const factory FeedEvent.started() = Started;
  const factory FeedEvent.refreshed() = Refreshed;
  const factory FeedEvent.postLiked(String postId, String userId) = PostLiked;
  const factory FeedEvent.postCommented(
    String postId,
    String comment,
    String userId,
  ) = PostCommented;
  const factory FeedEvent.createPost({
    required String caption,
    required File? image,
  }) = CreatePost;
  const factory FeedEvent.postDeleted(String postId) = PostDeleted;
}
