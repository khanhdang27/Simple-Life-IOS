import 'package:baseproject/blocs/app_bloc.dart';
import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/login/Input.dart';
import 'package:baseproject/screens/login/btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPwScreen extends StatefulWidget {
  @override
  _ForgotPwScreenState createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final codeCtrl = TextEditingController();

  String? _emailError;
  String? _passError;
  String? _passConfirmError;
  String? _codeError;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
    codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer(
        bloc: AppBloc.forgotPasswordBloc,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                child: Text(
                  AppLocalizations.t(context, 'forgotPassword'),
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
                  txtController: emailCtrl,
                  label: AppLocalizations.t(context, 'emailCtrl'),
                  errorText: _emailError,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Input(
                        label: AppLocalizations.t(context, 'verificationCode'),
                        txtController: codeCtrl,
                        errorText: _codeError,
                      ),
                    ),
                    InkWell(
                      radius: 30,
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppLocalizations.t(context, "getCode"),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: AppFont.wMedium,
                                  fontFamily: AppFont.madeTommySoft,
                                  color: AppColor.whiteMain,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.pinkLight,
                          borderRadius: BorderRadius.circular(37.5),
                        ),
                      ),
                      onTap: () {
                        if (emailCtrl.text.isEmpty) {
                          setState(() {
                            _emailError = AppLocalizations.t(context, "pleaseInputMail");
                          });
                        } else {
                          AppBloc.forgotPasswordBloc.add(GetCodeEvent(email: emailCtrl.text));
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: Input(
                  txtController: passCtrl,
                  label: AppLocalizations.t(context, 'newPassword'),
                  errorText: _passError,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                child: Input(
                  txtController: confirmPassCtrl,
                  label: AppLocalizations.t(context, 'confirmNewPassword'),
                  obscureText: true,
                  errorText: _passConfirmError,
                ),
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Btn(
                    languageKey: 'ok',
                    callback: () {
                      AppBloc.forgotPasswordBloc.add(
                        ResetPassword(
                          email: emailCtrl.text,
                          code: codeCtrl.text,
                          password: passCtrl.text,
                          confirmPassword: confirmPassCtrl.text,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state is GetCodeSuccess) {
            _emailError = null;
            Fluttertoast.showToast(
              msg: 'Email sent.',
              backgroundColor: AppColor.pinkLight,
              textColor: AppColor.redMain,
              timeInSecForIosWeb: 2,
            );
          } else if (state is GetCodeFailed) {
            _emailError = state.errors!['email'] ?? null;
          } else if (state is ResetPasswordFailed) {
            _emailError = state.errors!['email'] ?? null;
            _codeError = state.errors!['code'] ?? null;
            _passError = state.errors!['password'] ?? null;
            _passConfirmError = state.errors!['confirm_password'] ?? null;
          } else if (state is ResetPasswordSuccess) {
            _emailError = null;
            _codeError = null;
            _passError = null;
            _passConfirmError = null;
            Fluttertoast.showToast(
              msg: 'Password was changed.',
              backgroundColor: AppColor.pinkLight,
              textColor: AppColor.redMain,
              timeInSecForIosWeb: 2,
            );
          }
        },
      ),
    );
  }
}
