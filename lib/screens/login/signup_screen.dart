import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/login/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Input.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passError;
  String? _confirmPassError;

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
    codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer(
        bloc: AppBloc.userBloc,
        builder: (context, state) {
          if (state is! UserSignUpLoading) {
            return Column(
              children: [
                Container(
                  child: Text(
                    AppLocalizations.t(context, 'signUp'),
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
                    label: AppLocalizations.t(context, 'fullName'),
                    txtController: nameCtrl,
                    errorText: _nameError,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Input(
                    label: AppLocalizations.t(context, 'email'),
                    txtController: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    errorText: _emailError,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Input(
                    label: AppLocalizations.t(context, 'phoneNumber'),
                    txtController: phoneCtrl,
                    keyboardType: TextInputType.number,
                    errorText: _phoneError,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Input(
                    label: AppLocalizations.t(context, 'registerPassword'),
                    txtController: passCtrl,
                    obscureText: true,
                    errorText: _passError,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Input(
                    label: AppLocalizations.t(context, 'confirmPassword'),
                    txtController: confirmPassCtrl,
                    obscureText: true,
                    errorText: _confirmPassError,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.t(context, 'referralCode'),
                        style: TextStyle(
                            color: AppColor.blackContent,
                            fontFamily: AppFont.madeTommySoft,
                            fontWeight: AppFont.wLight,
                            fontSize: 20.24),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.blackContent,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              filled: true,
                              fillColor: AppColor.pinkLight,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppBloc.userBloc.add(UserSignUp(
                      name: nameCtrl.text,
                      email: emailCtrl.text,
                      phone: phoneCtrl.text,
                      password: passCtrl.text,
                      confirmPass: confirmPassCtrl.text,
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 300,
                      child: Btn(languageKey: 'signUpBtn'),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {
          if (state is UserSignUpSuccess) {
            Navigator.popUntil(context, ModalRoute.withName(AppRoute.login));
          }
          if (state is UserSignUpFailed) {
            _nameError = state.errors!['name'] ?? null;
            _emailError = state.errors!['email'] ?? null;
            _phoneError = state.errors!['phone'] ?? null;
            _passError = state.errors!['password'] ?? null;
            _confirmPassError = state.errors!['confirm_password'] ?? null;
          }
        },
      ),
    );
  }
}
