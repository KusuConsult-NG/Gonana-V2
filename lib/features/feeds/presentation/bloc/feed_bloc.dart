import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/feed_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';
import '../../data/models/post_model.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository _repository;

  FeedBloc(this._repository) : super(const FeedState.initial()) {
    on<Started>(_onStarted);
    on<Refreshed>(_onRefreshed);
    on<PostLiked>(_onPostLiked);
    on<PostCommented>(_onPostCommented);
    on<CreatePost>(_onCreatePost);
    on<PostDeleted>(_onPostDeleted);
  }

  Future<void> _onStarted(Started event, Emitter<FeedState> emit) async {
    emit(const FeedState.loading());
    final result = await _repository.getFeed();
    result.fold(
      (failure) => emit(FeedState.error(failure)),
      (feed) => emit(FeedState.loaded(feed)),
    );
  }

  Future<void> _onRefreshed(Refreshed event, Emitter<FeedState> emit) async {
    final result = await _repository.getFeed();
    result.fold(
      (failure) => emit(FeedState.error(failure)),
      (feed) => emit(FeedState.loaded(feed)),
    );
  }

  Future<void> _onPostLiked(PostLiked event, Emitter<FeedState> emit) async {
    state.maybeWhen(
      loaded: (feed) {
        final updatedPosts = feed.posts.map((post) {
          if (post.id == event.postId) {
            final isCurrentlyLiked = post.likedBy.contains(event.userId);
            final newLikedBy = List<String>.from(post.likedBy);
            if (isCurrentlyLiked) {
              newLikedBy.remove(event.userId);
            } else {
              newLikedBy.add(event.userId);
            }
            return PostModel.fromEntity(
              post.copyWith(
                likedBy: newLikedBy,
                likesCount: isCurrentlyLiked
                    ? post.likesCount - 1
                    : post.likesCount + 1,
                isLiked: !isCurrentlyLiked,
              ),
            );
          }
          return PostModel.fromEntity(post);
        }).toList();

        emit(FeedState.loaded(feed.copyWith(posts: updatedPosts)));

        // Call repository in background
        _repository.likePost(event.postId, event.userId);
      },
      orElse: () {},
    );
  }

  Future<void> _onPostCommented(
    PostCommented event,
    Emitter<FeedState> emit,
  ) async {
    state.maybeWhen(
      loaded: (feed) {
        final updatedPosts = feed.posts.map((post) {
          if (post.id == event.postId) {
            return PostModel.fromEntity(
              post.copyWith(commentsCount: post.commentsCount + 1),
            );
          }
          return PostModel.fromEntity(post);
        }).toList();

        emit(FeedState.loaded(feed.copyWith(posts: updatedPosts)));

        // Call repository in background
        _repository.commentOnPost(event.postId, event.comment, event.userId);
      },
      orElse: () {},
    );
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<FeedState> emit) async {
    try {
      emit(const FeedState.loading());
      // Just call repo
      await _repository.createPost(caption: event.caption, image: event.image);
      // Refresh feed
      add(const FeedEvent.refreshed());
    } catch (e) {
      // Simple error handling
      emit(FeedState.error(e.toString()));
    }
  }

  Future<void> _onPostDeleted(
    PostDeleted event,
    Emitter<FeedState> emit,
  ) async {
    state.maybeWhen(
      loaded: (feed) {
        final updatedPosts = feed.posts
            .where((p) => p.id != event.postId)
            .toList();
        emit(FeedState.loaded(feed.copyWith(posts: updatedPosts)));
        _repository.deletePost(event.postId);
      },
      orElse: () {},
    );
  }
}
