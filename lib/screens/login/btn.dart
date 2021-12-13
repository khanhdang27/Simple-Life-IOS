import 'package:baseproject/configs/app_color.dart';
import 'package:baseproject/configs/app_localizations.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';

class Btn extends StatelessWidget {
  final String languageKey;
  final VoidCallback? callback;
  final Icon? icon;

  const Btn({
    Key? key,
    required this.languageKey,
    this.callback,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
        padding: EdgeInsets.fromLTRB(30, 15, 20, 15),
        child: Row(
          children: [
            icon ?? SizedBox.shrink(),
            Expanded(
              child: Text(
                AppLocalizations.t(context, languageKey),
                style: TextStyle(
                  fontSize: 21,
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
      onTap: callback,
    );
  }
}
