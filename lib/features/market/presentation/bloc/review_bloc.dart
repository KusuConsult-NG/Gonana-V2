import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/market_repository.dart';

part 'review_event.dart';
part 'review_state.dart';
part 'review_bloc.freezed.dart';

@injectable
class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final MarketRepository _marketRepository;

  ReviewBloc(this._marketRepository) : super(const ReviewState.initial()) {
    on<_LoadReviews>(_onLoadReviews);
    on<_AddReview>(_onAddReview);
  }

  Future<void> _onLoadReviews(
    _LoadReviews event,
    Emitter<ReviewState> emit,
  ) async {
    emit(const ReviewState.loading());
    final result = await _marketRepository.getProductReviews(event.productId);
    result.fold(
      (error) => emit(ReviewState.error(error)),
      (reviews) => emit(ReviewState.loaded(reviews)),
    );
  }

  Future<void> _onAddReview(_AddReview event, Emitter<ReviewState> emit) async {
    emit(const ReviewState.loading());
    final result = await _marketRepository.addReview(event.review);
    result.fold((error) => emit(ReviewState.error(error)), (_) {
      emit(const ReviewState.reviewAdded());
      add(ReviewEvent.loadReviews(event.review.productId));
    });
  }
}
