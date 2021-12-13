import 'package:baseproject/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreditHeader {
  AppBar apply(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)!.settings.name;
    bool isHome = currentRoute == AppRoute.home;
    return AppBar(
      toolbarHeight: 66,
      leading: IconButton(
        icon: !isHome
            ? Icon(Icons.arrow_back_ios)
            : Icon(Icons.notifications_none),
        color: AppColor.rBMain,
        onPressed: () {
          if (isHome) {
          } else {
            if (AppRoute.mainRoutes.contains(currentRoute)) {
              Navigator.popUntil(context, ModalRoute.withName(AppRoute.home));
            } else {
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}
