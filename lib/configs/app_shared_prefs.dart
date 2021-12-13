import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static SharedPreferences? _preferences;

  static const loginInternal = 0;
  static const loginExternal = 1;

  static const _keyLoginType = 'loginType';
  static const _keyPhone = 'phone';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setLoginType(int loginType) async => await _preferences!.setInt(_keyLoginType, loginType);

  static int? getLoginType() => _preferences!.getInt(_keyLoginType);

  static Future setPhone(String phone) async => await _preferences!.setString(_keyPhone, phone);

  static String? getPhone() => _preferences!.getString(_keyPhone);

}
