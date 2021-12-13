import 'package:baseproject/configs/configs.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData generateTheme() {
    return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: AppColor.rBMain,
          displayColor: AppColor.rBMain,
        ),
        iconTheme: IconThemeData(color: AppColor.rBMain),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.rBMain,
        ),
        accentColor: AppColor.rBMain,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontFamily: AppFont.madeTommySoft,
            color: AppColor.rBMain,
          ),
        ),
        appBarTheme: AppBarTheme(backgroundColor: AppColor.pinkLight));
  }

  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
