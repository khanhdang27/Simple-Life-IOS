import 'dart:async';

import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/favorite_repository.dart';
import 'package:bloc/bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial());
  FavoriteRepository favoriteRepository = FavoriteRepository();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FavoriteGetList) {
      yield FavoriteProgressIndicator();
      List<Product> products = await favoriteRepository.get();
      yield FavoriteGetListSuccess(
        products: products,
        productIds: products.map((e) => e.id).toList(),
      );
    }
    if (event is FavoriteRequest) {
      List<Product> products = await favoriteRepository.request(event.productId);
      yield FavoriteGetListSuccess(
        products: products,
        productIds: products.map((e) => e.id).toList(),
      );
    }
    if (event is FavoriteMultipleRemove) {
      if (AppBloc.favoriteCheckBloc.state is FavoriteCheckState) {
        List<Product> products = await favoriteRepository.multipleRemove(
          productIds: AppBloc.favoriteCheckBloc.state.ids,
        );
        yield FavoriteGetListSuccess(
          products: products,
          productIds: products.map((e) => e.id).toList(),
        );
      }
    }
    if (event is FavoriteSync) {
      yield FavoriteProgressIndicator();
      List<Product> products = await favoriteRepository.sync();
      yield FavoriteGetListSuccess(
        products: products,
        productIds: products.map((e) => e.id).toList(),
      );
    }
  }
}
