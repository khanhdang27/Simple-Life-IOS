part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class GetCodeSuccess extends ForgotPasswordInitial {}

class GetCodeFailed extends ForgotPasswordInitial {
  final Map? errors;

  GetCodeFailed({this.errors});
}

class ResetPasswordSuccess extends ForgotPasswordState {}

class ResetPasswordFailed extends ForgotPasswordState {
  final Map? errors;

  ResetPasswordFailed({this.errors});
}
