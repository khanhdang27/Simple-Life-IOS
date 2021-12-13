import 'dart:convert';

import 'package:baseproject/blocs/app_bloc.dart';
import 'package:baseproject/blocs/auth/auth_bloc.dart';
import 'package:baseproject/configs/app_db.dart';
import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class CartRepository extends Repository {
  Future<List<Product>> add({
    required int productId,
    required int quantity,
  }) async {
    if (AppBloc.authBloc.state is Guest) {
      return _addFromDb(productId: productId, quantity: quantity);
    }
    FormData formData = FormData.fromMap({
      'product_id': productId,
      'quantity': quantity,
    });
    Map response = await httpManager.post(
      url: '/cart/add',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJsonCart(e);
    }).toList();
    return products;
  }

  Future<List<Product>> get() async {
    if (AppBloc.authBloc.state is Guest) {
      return getFromDb();
    }
    Map response = await httpManager.get(url: '/cart/get');
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJsonCart(e);
    }).toList();
    return products;
  }

  Future<List<Product>> remove({required int productId}) async {
    FormData formData = FormData.fromMap({
      'product_id': productId,
    });
    if (AppBloc.authBloc.state is Guest) {
      return removeFromDb(productId: productId);
    }
    Map response = await httpManager.post(
      url: '/cart/remove',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJsonCart(e);
    }).toList();
    return products;
  }

  Future<List<Product>> multipleRemove({required List productIds}) async {
    if (AppBloc.authBloc.state is Guest) {
      return multipleRemoveFromDb(productIds: productIds);
    }
    FormData formData = FormData.fromMap(
      {
        'product_ids': jsonEncode(productIds),
      },
    );
    Map response = await httpManager.post(
      url: '/cart/multiple-remove',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJsonCart(e);
    }).toList();
    return products;
  }

  Future<List<Product>> _addFromDb({
    required int productId,
    required int quantity,
  }) async {
    List<Map> products = await AppDb.db.query(
      AppDb.tbCart,
      columns: ['product_id'],
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    if (products.length > 0) {
      await AppDb.db.update(
        AppDb.tbCart,
        {'quantity': quantity},
        where: 'product_id = ?',
        whereArgs: [productId],
      );
    } else {
      await AppDb.db.insert(AppDb.tbCart, {'product_id': productId, 'quantity': quantity});
    }
    List<Map> productsAfter = await AppDb.db.query(
      AppDb.tbCart,
      columns: ['product_id', 'quantity'],
    );
    Map temp = {};
    List<dynamic> result = productsAfter.map((e) {
      temp[e['product_id']] = e['quantity'];
      return e['product_id'];
    }).toList();
    FormData formData = FormData.fromMap({
      'ids': jsonEncode(result),
    });
    Map response = await httpManager.post(
      url: '/product/find-multiple',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> productFromApi = responseRaw.map((e) {
      return Product.fromJsonDbCart(e, temp[int.parse(e['id'])]);
    }).toList();
    return productFromApi;
  }

  Future<List<Product>> getFromDb() async {
    List<Map> productsAfter = await AppDb.db.query(
      AppDb.tbCart,
      columns: ['product_id', 'quantity'],
    );
    Map temp = {};
    List<dynamic> result = productsAfter.map((e) {
      temp[e['product_id']] = e['quantity'];
      return e['product_id'];
    }).toList();
    FormData formData = FormData.fromMap({
      'ids': jsonEncode(result),
    });
    Map response = await httpManager.post(
      url: '/product/find-multiple',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> productFromApi = responseRaw.map((e) {
      return Product.fromJsonDbCart(e, temp[int.parse(e['id'])]);
    }).toList();
    return productFromApi;
  }

  Future<List<Product>> removeFromDb({required int productId}) async {
    await AppDb.db.delete(AppDb.tbCart, where: "product_id=?", whereArgs: [productId]);
    return await getFromDb();
  }

  Future<List<Product>> multipleRemoveFromDb({required List productIds}) async {
    productIds.forEach((element) async {
      await AppDb.db.delete(AppDb.tbCart, where: "product_id = ?", whereArgs: [element]);
    });
    return await getFromDb();
  }

  Future<List<Product>> sync() async {
    List data = await AppDb.db.query(AppDb.tbCart);
    if (data.length < 1) {
      return get();
    }
    FormData formData = FormData.fromMap({
      'data': jsonEncode(data),
    });
    Map response = await httpManager.post(
      url: '/cart/multi-add',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJsonCart(e);
    }).toList();
    await AppDb.db.delete(AppDb.tbCart, where: 'product_id > 0');
    return products;
  }
}
