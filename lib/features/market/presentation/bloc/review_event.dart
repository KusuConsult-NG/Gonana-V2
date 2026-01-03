part of 'review_bloc.dart';

@freezed
class ReviewEvent with _$ReviewEvent {
  const factory ReviewEvent.loadReviews(String productId) = _LoadReviews;
  const factory ReviewEvent.addReview(ReviewEntity review) = _AddReview;
}
