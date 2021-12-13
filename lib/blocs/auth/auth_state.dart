part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final UserIdentity user;

  AuthSuccess({required this.user});
}

class AuthFailed extends AuthState {}

class Guest extends AuthState {}

class LoginFailed extends AuthState {
  final Map? errors;

  LoginFailed({this.errors});
}
