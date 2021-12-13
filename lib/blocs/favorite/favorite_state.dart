part of 'favorite_bloc.dart';

abstract class FavoriteState {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {}

class FavoriteProgressIndicator extends FavoriteState {}

class FavoriteGetListSuccess extends FavoriteState {
  final List<Product> products;
  final List<int> productIds;

  FavoriteGetListSuccess({required this.products, required this.productIds});
}
