import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductDefault());
  ProductRepository productRepository = ProductRepository();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductEvent) {
      yield ProductDefault();
    }
    if (event is ProductGetHot) {
      List<Product> products = await productRepository.getHot();
      yield ProductGetHotSuccess(products: products);
    }
    if (event is ProductGetMaybeLike) {
      List<Product> products = await productRepository.getMaybeLike();
      yield ProductGetMaybeLikeSuccess(products: products);
    }
    if (event is ProductGetByCategory) {
      List<Product> products = await productRepository.getAll(
        event.category.id,
        ignore: event.ignore,
      );
      yield ProductGetByCategorySuccess(
        products: products,
        category: event.category,
      );
    }
  }
}
