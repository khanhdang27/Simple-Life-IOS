part of 'user_address_bloc.dart';

@immutable
abstract class UserAddressState {}

class UserAddressInitial extends UserAddressState {}

class UserAddressRequestSuccess extends UserAddressState {}

class UserAddressRequestFailed extends UserAddressState {
  final Map errors;

  UserAddressRequestFailed({required this.errors});
}
