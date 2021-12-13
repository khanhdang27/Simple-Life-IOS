import 'dart:async';

import 'package:baseproject/configs/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial());

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is LanguageSelect) {
      AppLanguage.selectedLanguage = event.language;
      yield LanguageSelectSuccess();
      SharedPreferences langPrefs = await SharedPreferences.getInstance();
      await langPrefs.setString(
        AppLanguage.appLanguageKey,
        event.language.toString(),
      );
    }
  }
}
