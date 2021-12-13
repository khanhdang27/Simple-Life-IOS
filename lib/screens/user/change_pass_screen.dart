import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/app_localizations.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/login/btn.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController oldPassCtrl = TextEditingController();
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();
  String? oldError;
  String? confirmError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                AppLocalizations.t(context, 'changePass'),
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Text(AppLocalizations.t(context, 'oldPass')),
          input(
            controller: oldPassCtrl,
            errorText: oldError,
          ),
          Text(AppLocalizations.t(context, 'newPass')),
          input(
            controller: newPassCtrl,
          ),
          Text(AppLocalizations.t(context, 'confirmPassword')),
          input(controller: confirmPassCtrl, errorText: confirmError),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Btn(
              languageKey: 'change',
              callback: () {
                if (newPassCtrl.text != confirmPassCtrl.text) {
                  setState(() {
                    confirmError = AppLocalizations.t(context, 'confirmError');
                  });
                } else {
                  AppBloc.userBloc.add(ChangePassword(
                      oldPass: oldPassCtrl.text,
                      newPass: newPassCtrl.text,
                      confirmPass: confirmPassCtrl.text));
                  setState(() {
                    confirmError = null;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

input({
  required TextEditingController controller,
  String? errorText,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: TextFormField(
      obscureText: true,
      controller: controller,
      style: TextStyle(
        color: AppColor.blackContent,
        fontWeight: AppFont.wMedium,
        fontSize: 22,
      ),
      decoration: InputDecoration(
        errorText: errorText ?? null,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.pinkLight,
          ),
        ),
      ),
    ),
  );
}
