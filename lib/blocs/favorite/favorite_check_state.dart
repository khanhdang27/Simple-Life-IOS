part of 'favorite_check_bloc.dart';

class FavoriteCheckState {
  final List ids;
  final bool value;

  FavoriteCheckState({required this.ids, required this.value});
}

class FavoriteCheckAllSuccess extends FavoriteCheckState {
  FavoriteCheckAllSuccess({ids, value}) : super(ids: ids, value: value);
}

class FavoriteCheckOneSuccess extends FavoriteCheckState {
  FavoriteCheckOneSuccess({ids, value}) : super(ids: ids, value: value);
}
