import 'dart:async';

import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_address_event.dart';

part 'user_address_state.dart';

class UserAddressBloc extends Bloc<UserAddressEvent, UserAddressState> {
  UserAddressBloc() : super(UserAddressInitial());
  UserRepository userRepository = UserRepository();

  @override
  Stream<UserAddressState> mapEventToState(UserAddressEvent event) async* {
    if (event is UserAddressRequest) {
      Map response = await userRepository.addressRequest(event.address);
      if (response['status'] == 200) {
        yield UserAddressRequestSuccess();
      } else {
        yield UserAddressRequestFailed(errors: response['errors']);
      }
    }
  }
}
