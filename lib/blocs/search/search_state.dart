part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchGetSuccess extends SearchState {
  final List<Product> products;
  final String? keyword;

  SearchGetSuccess({required this.products, this.keyword});
}
