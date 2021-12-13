part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackEvent {}

class FeedbackAdd extends FeedbackEvent {
  final int productId;
  final double score;
  final String feedback;

  FeedbackAdd({
    required this.productId,
    required this.score,
    required this.feedback,
  });
}

class FeedbackEdit extends FeedbackEvent {}

class FeedbackRemove extends FeedbackEvent {}
