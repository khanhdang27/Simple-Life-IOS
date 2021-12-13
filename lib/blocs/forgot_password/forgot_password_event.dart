part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class GetCodeEvent extends ForgotPasswordEvent {
  final String email;

  GetCodeEvent({required this.email});
}

class ResetPassword extends ForgotPasswordEvent {
  final String email;
  final String code;
  final String password;
  final String confirmPassword;

  ResetPassword({
    required this.email,
    required this.code,
    required this.password,
    required this.confirmPassword,
  });
}
