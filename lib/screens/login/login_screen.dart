import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/login/Input.dart';
import 'package:baseproject/screens/login/btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  String? _emailError;
  String? _passError;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              AppLocalizations.t(context, 'loginTitle'),
              style: TextStyle(
                  fontSize: 60,
                  color: AppColor.rBMain,
                  fontFamily: AppFont.centuryGothic,
                  fontWeight: AppFont.wRegular),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Input(
              label: AppLocalizations.t(context, 'emailOrPhone'),
              txtController: emailEditingController,
              errorText: _emailError,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Input(
              txtController: passwordEditingController,
              label: AppLocalizations.t(context, 'yourPassword'),
              obscureText: true,
              errorText: _passError,
            ),
          ),
          BlocListener(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoute.home,
                  (Route<dynamic> route) => false,
                );
              } else if (state is LoginFailed) {
                if (state.errors != null) {
                  setState(() {
                    _emailError = state.errors!['username'] ?? null;
                    _passError = state.errors!['password'] ?? null;
                  });
                }
              }
            },
            bloc: AppBloc.authBloc,
            child: SizedBox(
              width: 300,
              child: Wrap(
                children: [
                  Btn(
                    languageKey: 'loginBtn',
                    callback: () {
                      if (emailEditingController.text.isNotEmpty &&
                          passwordEditingController.text.isNotEmpty) {
                        AppBloc.authBloc.add(
                          AuthLogin(
                            password: passwordEditingController.text,
                            email: emailEditingController.text,
                          ),
                        );
                      }
                    },
                  ),
                  Btn(
                    languageKey: 'ggLoginBtn',
                    callback: () async {
                      try {
                        await _googleSignIn.signIn();
                        AppBloc.authBloc.add(
                          AuthLoginGoogle(
                            currentUser: _googleSignIn.currentUser,
                          ),
                        );
                      } catch (e) {
                        throw e;
                      }
                    },
                    icon: Icon(
                      AppIcon.g,
                      color: AppColor.whiteMain,
                      size: 30,
                    ),
                  ),
                  Btn(
                    languageKey: 'fbLoginBtn',
                    callback: () {
                      Fluttertoast.showToast(
                        msg: 'Function is building.',
                        backgroundColor: AppColor.pinkLight,
                        textColor: AppColor.redMain,
                        timeInSecForIosWeb: 2,
                      );
                      // _googleSignIn.signOut();
                    },
                    icon: Icon(
                      AppIcon.f,
                      color: AppColor.whiteMain,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text(
                  AppLocalizations.t(context, 'signUp'),
                  style: TextStyle(
                    color: AppColor.rBMain,
                    fontFamily: AppFont.madeTommySoft,
                    fontSize: 18,
                    fontWeight: AppFont.wLight,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.signUp);
                },
              ),
              Text(
                " / ",
                style: TextStyle(
                  color: AppColor.rBMain,
                  fontFamily: AppFont.madeTommySoft,
                  fontSize: 18,
                  fontWeight: AppFont.wLight,
                ),
              ),
              GestureDetector(
                child: Text(
                  AppLocalizations.t(context, 'forgotPassword'),
                  style: TextStyle(
                    color: AppColor.rBMain,
                    fontFamily: AppFont.madeTommySoft,
                    fontSize: 18,
                    fontWeight: AppFont.wLight,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.forgotPw);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
