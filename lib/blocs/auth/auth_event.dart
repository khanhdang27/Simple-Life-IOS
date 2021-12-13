part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthCheck extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

class AuthLogout extends AuthEvent {}

class AuthLoginGoogle extends AuthEvent {
  final GoogleSignInAccount? currentUser;

  AuthLoginGoogle({this.currentUser});
}
