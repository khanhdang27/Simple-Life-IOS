part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackAddSuccess extends FeedbackState {}

class FeedbackEditSuccess extends FeedbackState {}

class FeedbackRemoveSuccess extends FeedbackState {}
