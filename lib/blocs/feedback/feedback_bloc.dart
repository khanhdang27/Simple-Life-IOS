import 'dart:async';

import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial());
  FeedbackRepository feedbackRepository = FeedbackRepository();

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    if (event is FeedbackAdd) {
      await feedbackRepository.add(
        productId: event.productId,
        score: event.score,
        feedback: event.feedback,
      );
      yield FeedbackAddSuccess();
    }
  }
}
