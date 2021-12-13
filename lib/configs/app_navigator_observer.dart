import 'package:flutter/cupertino.dart';

final AppNavigatorObserver appNavigatorObserver = AppNavigatorObserver();

class AppNavigatorObserver extends NavigatorObserver {
  List<String> routeStack = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      routeStack.add(route.settings.name!);
    }
    super.didPush(route, previousRoute);
  }

  //Pop là xóa từ last xóa xuống
  @override
  void didPop(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      routeStack.removeLast();
    }
    super.didPop(route, previousRoute);
  }

  //Remove là xóa từ first xóa lên
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      routeStack.removeAt(0);
    }
    super.didPop(route, previousRoute);
  }

  static final AppNavigatorObserver _instance =
      AppNavigatorObserver._internal();

  factory AppNavigatorObserver() {
    return _instance;
  }

  AppNavigatorObserver._internal();
}
