part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchGet extends SearchEvent {
  final String keyword;

  SearchGet({required this.keyword});
}

class SearchSort extends SearchEvent {
  final String type;

  SearchSort({required this.type});
}
