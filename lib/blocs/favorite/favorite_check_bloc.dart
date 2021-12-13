import 'dart:async';

import 'package:baseproject/blocs/blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'favorite_check_event.dart';

part 'favorite_check_state.dart';

class FavoriteCheckBloc extends Bloc<FavoriteCheckEvent, FavoriteCheckState> {
  FavoriteCheckBloc() : super(FavoriteCheckState(ids: [], value: true));

  @override
  Stream<FavoriteCheckState> mapEventToState(FavoriteCheckEvent event) async* {
    List<int> ids = [];
    if (AppBloc.favoriteBloc.state is FavoriteGetListSuccess) {
      FavoriteGetListSuccess favoriteState =
          AppBloc.favoriteBloc.state as FavoriteGetListSuccess;
      ids = favoriteState.products.map((e) => e.id).toList();
    }
    if (event is FavoriteCheckAll) {
      List<int> response = [];
      if (event.value == true) {
        response = ids;
      }
      yield FavoriteCheckAllSuccess(
        value: event.value,
        ids: response,
      );
    }
    if (event is FavoriteCheckOne) {
      if (event.value == true) {
        state.ids.add(event.id);
      } else {
        state.ids.remove(event.id);
      }
      if (state.ids.length == ids.length) {
        yield FavoriteCheckAllSuccess(
          value: event.value,
          ids: state.ids,
        );
      } else {
        yield FavoriteCheckOneSuccess(
          value: event.value,
          ids: state.ids,
        );
      }
    }
  }
}
