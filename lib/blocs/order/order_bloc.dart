import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/order_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial());
  OrderRepository orderRepository = OrderRepository();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is OrderGet) {
      yield OrderInitial();
      List<Order> orders = await orderRepository.get();
      yield OrderGetSuccess(orders: orders);
    }
  }
}
