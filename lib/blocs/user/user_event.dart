part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserSignUp extends UserEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPass;

  UserSignUp({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPass,
  });
}

class ChangePassword extends UserEvent {
  final String oldPass;
  final String newPass;
  final String confirmPass;

  ChangePassword({
    required this.oldPass,
    required this.newPass,
    required this.confirmPass
  });
}

class UpdateProfile extends UserEvent {
  final String? phone;
  final String? name;

  UpdateProfile({
    this.phone,
    this.name,
  });
}

class UserReset extends UserEvent{}
