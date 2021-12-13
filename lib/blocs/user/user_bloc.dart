import 'dart:async';

import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/app_shared_prefs.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());
  UserRepository userRepository = UserRepository();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserReset) {
      yield UserInitial();
    }

    if (event is UserSignUp) {
      yield UserSignUpLoading();
      Map response = await userRepository.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
        confirm: event.confirmPass,
        phone: event.phone,
      );
      if (response['status'] == 200) {
        yield UserSignUpSuccess();
      } else {
        yield UserSignUpFailed(errors: response['errors']);
      }
    }

    if(event is ChangePassword){
      Map response = await userRepository.changePassword(
        oldPass: event.oldPass,
        newPass: event.newPass,
        confirmPass: event.confirmPass,
      );
      if (response['status'] == 200) {
        yield ChangePasswordSuccess();
      } else {
        yield ChangePasswordFailed(errors: response['errors']);
      }
    }

    if(event is UpdateProfile){
      Map response = await userRepository.updateProfile(
        phone: event.phone,
        name: event.name,
      );
      if (response['status'] == 200) {
        AppSharedPrefs.setPhone(event.phone!);
        AppBloc.profileBloc.add(ProfileGet());
        yield UpdateProfileSuccess();
      } else {
        yield UpdateProfileFailed(errors: response['errors']);
      }
    }
  }
}
