part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserSignUpLoading extends UserState {}

class UserSignUpSuccess extends UserState {}

class UserSignUpFailed extends UserState {
  final Map? errors;

  UserSignUpFailed({this.errors});
}

class ChangePasswordSuccess extends UserState {}

class ChangePasswordFailed extends UserState {
  final Map? errors;

  ChangePasswordFailed({this.errors});
}

class UpdateProfileSuccess extends UserState {}

class UpdateProfileFailed extends UserState {
  final Map? errors;

  UpdateProfileFailed({this.errors});
}
