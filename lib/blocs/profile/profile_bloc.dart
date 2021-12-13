import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
  UserRepository userRepository = UserRepository();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileGet) {
      yield ProfileInitial();
      User user = await userRepository.profile();
      yield ProfileGetSuccess(user: user);
    }
  }
}
