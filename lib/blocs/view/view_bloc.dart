import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_event.dart';

part 'view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  ViewBloc() : super(ViewHomeSuccess());

  @override
  Stream<ViewState> mapEventToState(ViewEvent event) async* {
    if (event is ViewHome) {
      yield ViewHomeSuccess();
    }
    if (event is ViewCategory) {
      yield ViewCategorySuccess();
    }
  }
}
