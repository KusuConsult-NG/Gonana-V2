import 'package:equatable/equatable.dart';
import 'post_entity.dart';
import 'story_entity.dart';

class FeedEntity extends Equatable {
  final List<PostEntity> posts;
  final List<StoryEntity> stories;

  const FeedEntity({this.posts = const [], this.stories = const []});

  @override
  List<Object?> get props => [posts, stories];
}
