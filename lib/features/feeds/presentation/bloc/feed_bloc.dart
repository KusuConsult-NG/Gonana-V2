import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/feed_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository _repository;

  FeedBloc(this._repository) : super(const FeedState.initial()) {
    on<Started>(_onStarted);
    on<Refreshed>(_onRefreshed);
    on<PostLiked>(_onPostLiked);
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
    // In a real app, we would optimistically update the state locally
    // or wait for the server response. For now, we'll just log it.
    await _repository.likePost(event.postId);
  }
}
