part of 'user_address_bloc.dart';

@immutable
abstract class UserAddressEvent {}

class UserAddressRequest extends UserAddressEvent {
  final String address;

  UserAddressRequest({required this.address});
}
