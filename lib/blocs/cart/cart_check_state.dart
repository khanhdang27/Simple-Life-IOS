part of 'cart_check_bloc.dart';

class CartCheckState {
  final List ids;
  final bool value;

  CartCheckState({required this.ids, required this.value});
}

class CartCheckAllSuccess extends CartCheckState {
  CartCheckAllSuccess({ids, value}) : super(ids: ids, value: value);
}

class CartCheckOneSuccess extends CartCheckState {
  CartCheckOneSuccess({ids, value}) : super(ids: ids, value: value);
}
