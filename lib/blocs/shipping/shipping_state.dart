part of 'shipping_bloc.dart';

@immutable
abstract class ShippingState {}

class ShippingInitial extends ShippingState {}

class ShippingGetSuccess extends ShippingState {
  final Shipping shipping;

  ShippingGetSuccess({required this.shipping});
}
class ShippingGetFailed extends ShippingState{}