import 'dart:async';

import 'package:baseproject/repositories/forgot_password_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial());
  ForgotPasswordRepository forgotPasswordRepository = ForgotPasswordRepository();

  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async* {
    if (event is GetCodeEvent) {
      try {
        Map response = await forgotPasswordRepository.getCode(email: event.email);
        if (response['status'] == 200) {
          yield GetCodeSuccess();
        } else {
          yield GetCodeFailed(errors: response['errors']);
        }
      } catch (error) {
        yield GetCodeFailed();
      }
    }
    if (event is ResetPassword) {
      try {
        Map response = await forgotPasswordRepository.resetPassword(
          email: event.email,
          code: event.code,
          password: event.password,
          confirm: event.confirmPassword,
        );
        if (response['status'] == 200) {
          yield ResetPasswordSuccess();
        } else {
          yield ResetPasswordFailed(errors: response['errors']);
        }
      } catch (error) {
        yield GetCodeFailed();
      }
    }
  }
}
