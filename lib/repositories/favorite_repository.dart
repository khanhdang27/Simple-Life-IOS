import 'dart:convert';

import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:dio/dio.dart';

import 'repository.dart';

class FavoriteRepository extends Repository {
  Future<List<Product>> request(int productId) async {
    if (AppBloc.authBloc.state is Guest) {
      return requestFromDb(productId);
    }
    FormData formData = FormData.fromMap({
      'product_id': productId,
    });
    Map response = await httpManager.post(
      url: '/favorite/request',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJson(e);
    }).toList();
    return products;
  }

  Future<List<Product>> get() async {
    if (AppBloc.authBloc.state is Guest) {
      return getFromDb();
    }
    Map response = await httpManager.post(
      url: '/favorite/index',
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJson(e);
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
      url: '/favorite/multiple-remove',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJsonCart(e);
    }).toList();
    return products;
  }

  Future<List<Product>> getFromDb() async {
    List<Map> productsAfter = await AppDb.db.query(
      AppDb.tbFavorite,
      columns: ['product_id'],
    );
    List<dynamic> result = productsAfter.map((e) {
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
    List<Map> productsCart = await AppDb.db.query(
      AppDb.tbCart,
      columns: ['product_id', 'quantity'],
    );
    Map temp = {};
    productsCart.forEach((e) {
      temp[e['product_id']] = e['quantity'];
    });
    List<Product> productFromApi = responseRaw.map((e) {
      return Product.fromJsonDbCart(e, temp[int.parse(e['id'])] ?? 0);
    }).toList();
    return productFromApi;
  }

  Future<List<Product>> requestFromDb(int productId) async {
    List<Map> products = await AppDb.db.query(
      AppDb.tbFavorite,
      columns: ['product_id'],
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    if (products.length > 0) {
      await AppDb.db.delete(AppDb.tbFavorite, where: 'product_id = ?', whereArgs: [productId]);
    } else {
      await AppDb.db.insert(AppDb.tbFavorite, {'product_id': productId});
    }
    return getFromDb();
  }

  Future<List<Product>> multipleRemoveFromDb({required List productIds}) async {
    String ids = productIds.join(",");
    await AppDb.db.rawDelete("DELETE FROM ${AppDb.tbFavorite} WHERE product_id IN ($ids)");
    return await getFromDb();
  }

  Future<List<Product>> sync() async {
    List data = await AppDb.db.query(AppDb.tbFavorite);
    if (data.length < 1) {
      return get();
    }
    FormData formData = FormData.fromMap({
      'data': jsonEncode(data),
    });
    Map response = await httpManager.post(
      url: '/favorite/multiple-add',
      data: formData,
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJsonCart(e);
    }).toList();
    await AppDb.db.delete(AppDb.tbFavorite, where: 'product_id > 0');
    return products;
  }
}
