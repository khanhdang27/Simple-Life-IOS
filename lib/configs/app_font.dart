import 'dart:ui';

class AppFont {
  //Font Family
  static String centuryGothic = "Century Gothic";
  static String madeTommySoft = "MADE Tommy Soft";
  static String monospace = "Gen-Jyuu-Gothic-X-Monospace";

  //Font weight
  static FontWeight wLight = FontWeight.w300;
  static FontWeight wRegular = FontWeight.w400;
  static FontWeight wMedium = FontWeight.w500;
  static FontWeight wSemiBold = FontWeight.w600;
  static FontWeight wBold = FontWeight.w700;

  static final AppFont _instance = AppFont._internal();

  factory AppFont() {
    return _instance;
  }

  AppFont._internal();
}
