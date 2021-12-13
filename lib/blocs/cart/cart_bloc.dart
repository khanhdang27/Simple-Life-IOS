import 'dart:async';

import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/cart_repository.dart';
import 'package:bloc/bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());
  CartRepository cartRepository = CartRepository();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartAdd) {
      List<Product> products = await cartRepository.add(
        productId: event.productId,
        quantity: event.quantity,
      );
      int totalQuantity = 0;
      double totalAmount = 0.0;
      products.forEach((element) {
        totalAmount = totalAmount + element.amount!;
        totalQuantity = totalQuantity + element.inCart!;
      });
      yield CartShowSuccess();
      yield CartSuccess(
        products: products,
        amount: totalAmount,
        quantity: totalQuantity,
        cost: totalAmount,
      );
    }
    if (event is CartGet) {
      yield CartInitial();
      List<Product> products = await cartRepository.get();
      int totalQuantity = 0;
      double totalAmount = 0.0;
      products.forEach((element) {
        totalAmount = totalAmount + element.amount!;
        totalQuantity = totalQuantity + element.inCart!;
      });
      yield CartSuccess(
        products: products,
        amount: totalAmount,
        quantity: totalQuantity,
        cost: totalAmount,
      );
    }
    if (event is CartRemove) {
      List<Product> products = await cartRepository.remove(
        productId: event.productId,
      );
      int totalQuantity = 0;
      double totalAmount = 0.0;
      products.forEach((element) {
        totalAmount = totalAmount + element.amount!;
        totalQuantity = totalQuantity + element.inCart!;
      });
      yield CartSuccess(
        products: products,
        amount: totalAmount,
        quantity: totalQuantity,
        cost: totalAmount,
      );
    }
    if (event is CartMultipleRemove) {
      yield CartInitial();
      if (AppBloc.cartCheckBloc.state is CartCheckState) {
        List<Product> products = await cartRepository.multipleRemove(
          productIds: AppBloc.cartCheckBloc.state.ids,
        );
        int totalQuantity = 0;
        double totalAmount = 0.0;
        products.forEach((element) {
          totalAmount = totalAmount + element.amount!;
          totalQuantity = totalQuantity + element.inCart!;
        });
        yield CartSuccess(
          products: products,
          amount: totalAmount,
          quantity: totalQuantity,
          cost: totalAmount,
        );
      }
    }
    if (event is CartSync) {
      yield CartInitial();
      List<Product> products = await cartRepository.sync();
      int totalQuantity = 0;
      double totalAmount = 0.0;
      products.forEach((element) {
        totalAmount = totalAmount + element.amount!;
        totalQuantity = totalQuantity + element.inCart!;
      });
      yield CartSuccess(
        products: products,
        amount: totalAmount,
        quantity: totalQuantity,
        cost: totalAmount,
      );
    }
  }
}
