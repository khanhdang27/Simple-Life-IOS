part of 'favorite_check_bloc.dart';

@immutable
abstract class FavoriteCheckEvent {}

class FavoriteCheckAll extends FavoriteCheckEvent {
  final bool value;

  FavoriteCheckAll({required this.value});
}

class FavoriteCheckOne extends FavoriteCheckEvent {
  final int id;
  final bool value;

  FavoriteCheckOne({required this.id, this.value = true});
}
