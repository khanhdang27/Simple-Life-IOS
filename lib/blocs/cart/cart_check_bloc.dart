import 'dart:async';

import 'package:baseproject/blocs/blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'cart_check_event.dart';

part 'cart_check_state.dart';

class CartCheckBloc extends Bloc<CartCheckEvent, CartCheckState> {
  CartCheckBloc() : super(CartCheckState(ids: [], value: true));

  @override
  Stream<CartCheckState> mapEventToState(CartCheckEvent event) async* {
    List<int> ids = [];
    if (AppBloc.cartBloc.state is CartSuccess) {
      CartSuccess cartState = AppBloc.cartBloc.state as CartSuccess;
      ids = cartState.products.map((e) => e.id).toList();
    }
    if (event is CartCheckAll) {
      List<int> response = [];
      if (event.value == true) {
        response = ids;
      }
      yield CartCheckAllSuccess(
        value: event.value,
        ids: response,
      );
    }
    if (event is CartCheckOne) {
      if (event.value == true) {
        state.ids.add(event.id);
      } else {
        state.ids.remove(event.id);
      }
      if (state.ids.length == ids.length) {
        yield CartCheckAllSuccess(
          value: event.value,
          ids: state.ids,
        );
      } else {
        yield CartCheckOneSuccess(
          value: event.value,
          ids: state.ids,
        );
      }
    }
  }
}
