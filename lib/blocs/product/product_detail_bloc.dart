import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial());
  ProductRepository productRepository = ProductRepository();

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is ProductDetailGet) {
      yield ProductDetailInitial();
      Product? product = await productRepository.one(event.productId);
      if (product != null) {
        yield ProductDetailGetSuccess(product: product);
      }
    }
  }
}
