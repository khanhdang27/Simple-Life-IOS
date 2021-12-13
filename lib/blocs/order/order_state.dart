part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderGetSuccess extends OrderState {
  final List<Order> orders;

  OrderGetSuccess({required this.orders});
}
