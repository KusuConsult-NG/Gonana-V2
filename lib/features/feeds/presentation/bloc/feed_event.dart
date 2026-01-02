import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_event.freezed.dart';

@freezed
class FeedEvent with _$FeedEvent {
  const factory FeedEvent.started() = Started;
  const factory FeedEvent.refreshed() = Refreshed;
  const factory FeedEvent.postLiked(String postId) = PostLiked;
}
