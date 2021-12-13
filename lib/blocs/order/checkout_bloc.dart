import 'dart:async';

import 'package:baseproject/repositories/order_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial());
  OrderRepository orderRepository = OrderRepository();

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is CheckoutConfirm) {
      yield CheckoutConfirmLoading();
      try {
        Map response = await orderRepository.confirm(
          method: event.method,
          delivery: event.delivery,
          address: event.address,
          fee: event.fee,
          coupon: event.coupon,
        );
        if (response['status'] == 200) {
          yield CheckoutConfirmSuccess(checkoutLink: response['link']);
        } else {
          yield CheckoutConfirmFail();
        }
      } catch (error) {
        yield CheckoutConfirmFail();
      }
    }
  }
}
