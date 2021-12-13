import 'dart:async';

import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  final AuthRepository authRepository = AuthRepository();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthCheck) {
      UserIdentity? loggedUser = (await checkLogin());
      if (loggedUser != null) {
        yield AuthSuccess(user: loggedUser);
        AppBloc.favoriteBloc.add(FavoriteGetList());
        AppBloc.cartBloc.add(CartGet());
      } else {
        yield Guest();
        AppBloc.cartBloc.add(CartGet());
      }
    }
    if (event is AuthLogin) {
      var user = await _login(params: {
        'username': event.email,
        'password': event.password,
      });
      if (user is! UserIdentity) {
        yield LoginFailed(errors: user);
      } else {
        yield AuthSuccess(user: user);
        AppBloc.favoriteBloc.add(FavoriteSync());
        AppBloc.cartBloc.add(CartSync());
      }
    }
    if (event is AuthLoginGoogle) {
      GoogleSignInAccount? googleSignInAccount = event.currentUser;
      if (googleSignInAccount != null) {
        UserIdentity user = await _login(
          params: {
            'id': googleSignInAccount.id,
            'email': googleSignInAccount.email,
            'name': googleSignInAccount.displayName,
          },
          external: true,
        );
        yield AuthSuccess(user: user);
        AppBloc.favoriteBloc.add(FavoriteSync());
        AppBloc.cartBloc.add(CartSync());
      }
    }
    if (event is AuthLogout) {
      await _logout();
      yield AuthFailed();
    }
  }

  /// Nếu có user thì pass
  Future<UserIdentity?> checkLogin() async {
    final List users = await AppDb.db.query(
      AppDb.tbUser,
      where: 'is_login = 10',
    );
    if (users.length > 0) {
      UserIdentity user = UserIdentity(id: users[0]['user_id'], token: users[0]['token']);
      return user;
    }
    return null;
  }

  Future<dynamic> _login({
    required Map params,
    bool external = false,
  }) async {
    var user;
    if (!external) {
      user = await authRepository.login(params['username'], params['password']);
      AppSharedPrefs.setLoginType(AppSharedPrefs.loginInternal);
      if (user is! UserIdentity) {
        return user;
      }
    } else {
      user = await authRepository.loginExternal(
        id: params['id'],
        email: params['email'],
        name: params['name'],
      );
      AppSharedPrefs.setLoginType(AppSharedPrefs.loginExternal);
    }

    final List users = await AppDb.db.query(
      AppDb.tbUser,
      where: 'user_id = ?',
      whereArgs: [user.id],
    );
    Batch batch = AppDb.db.batch();
    if (users.length > 0) {
      batch.update(
        AppDb.tbUser,
        {'is_login': 10, 'token': user.token},
        where: 'user_id = ?',
        whereArgs: [user.id],
      );
    } else {
      batch.insert(
        AppDb.tbUser,
        {'user_id': user.id, 'token': user.token, 'is_login': 10},
      );
    }
    await batch.commit(noResult: true);
    return UserIdentity(id: user.id, token: user.token);
  }

  Future<void> _logout() async {
    Batch batch = AppDb.db.batch();
    batch.update(
      AppDb.tbUser,
      {'is_login': 0, 'token': null},
      where: 'is_login = 10',
    );
    await batch.commit(noResult: true);
  }
}
