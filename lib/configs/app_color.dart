import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColor {
  static Color rBMain = Color.fromRGBO(178, 119, 118, 1.0);
  static Color pinkLight = Color.fromRGBO(255, 195, 194, 1.0);
  static Color whiteMain = Color.fromRGBO(255, 255, 255, 1);
  static Color brownBorder = Color.fromRGBO(209, 173, 173, 1);
  static Color pinkDropdown = Color.fromRGBO(240, 228, 228, 1);
  static Color pinkDropdownFocus = Color.fromRGBO(224, 201, 200, 1);

  static Color red593B = Color.fromRGBO(89, 60, 59, 1.0);
  static Color blackContent = Color.fromRGBO(115, 104, 104, 1);
  static Color redMain = Color(0xFFFF0000);
  static Color brownPink = Color.fromARGB(255, 210, 150, 134);
  static Color orangePink = Color.fromARGB(255, 249, 204, 177);
  static Color yellowLight = Color.fromARGB(255, 252, 229, 193);

  static final AppColor _instance = AppColor._internal();

  factory AppColor() {
    return _instance;
  }

  AppColor._internal();
}
