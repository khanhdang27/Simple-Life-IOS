part of 'cart_check_bloc.dart';

@immutable
abstract class CartCheckEvent {}

class CartCheckAll extends CartCheckEvent {
  final bool value;

  CartCheckAll({required this.value});
}

class CartCheckOne extends CartCheckEvent {
  final int id;
  final bool value;

  CartCheckOne({required this.id, this.value = true});
}
