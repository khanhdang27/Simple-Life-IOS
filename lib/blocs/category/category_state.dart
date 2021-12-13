part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryProgressIndicator extends CategoryState {}

class CategoryGetAllSuccess extends CategoryState {
  final List<Category>? categories;

  CategoryGetAllSuccess({this.categories});
}
