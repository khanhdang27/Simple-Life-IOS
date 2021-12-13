part of 'favorite_bloc.dart';

abstract class FavoriteEvent {
  const FavoriteEvent();
}

class FavoriteGetList extends FavoriteEvent {}

class FavoriteRequest extends FavoriteEvent {
  final int productId;

  FavoriteRequest({required this.productId});
}

class FavoriteMultipleRemove extends FavoriteEvent {}

class FavoriteSync extends FavoriteEvent {}
