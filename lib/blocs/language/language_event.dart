part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class LanguageSelect extends LanguageEvent {
  final Locale language;

  LanguageSelect({required this.language});
}
