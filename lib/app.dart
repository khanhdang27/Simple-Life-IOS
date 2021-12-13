import 'dart:io';

import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Simply Life',
            home: Setup(),
            onGenerateRoute: AppRoute().generateRoute,
            locale: AppLanguage.selectedLanguage,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLanguage.supportLanguage,
            theme: AppTheme().generateTheme(),
            themeMode: ThemeMode.light,
            navigatorObservers: [appNavigatorObserver],
          );
        },
      ),
    );
  }
}

class Setup extends StatelessWidget {
  final databaseProvider = AppDb();

  Setup() {
    HttpOverrides.global = new IgnoreCertificateErrorOverrides();
    setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteMain,
      body: BlocListener(
        bloc: AppBloc.authBloc,
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.home,
              (Route<dynamic> route) => false,
            );
          }
          if (state is Guest) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.guestHome,
              (Route<dynamic> route) => false,
            );
          }
          if (state is AuthFailed) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.login,
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> setUp() async {
    await databaseProvider.setupDatabase();
    AppBloc.authBloc.add(AuthCheck());
    await AppSharedPrefs.init();
    await setLanguage();
  }

  Future<void> setLanguage() async {
    SharedPreferences langPrefs = await SharedPreferences.getInstance();
    String? language = langPrefs.getString(AppLanguage.appLanguageKey);
    if (language != null) {
      List langTemp = language.split('_');
      AppLanguage.selectedLanguage = Locale(langTemp[0]);
      if (langTemp.length > 1) {
        AppLanguage.selectedLanguage = Locale(langTemp[0], langTemp[1]);
      }
    }
  }
}

class IgnoreCertificateErrorOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
        return true;
      });
  }
}
