import 'package:baseproject/models/models.dart';

import 'repository.dart';

class ProductRepository extends Repository {
  Future<List<Product>> getHot() async {
    Map response = await httpManager.get(url: '/product/list-hot');
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJson(e);
    }).toList();
    return products;
  }

  Future<List<Product>> getMaybeLike() async {
    Map response = await httpManager.get(url: '/product/maybe-like');
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJson(e);
    }).toList();
    return products;
  }

  Future<List<Product>> getAll(int categoryId, {int? ignore}) async {
    String url = "/product/index?category=$categoryId";
    if (ignore != null) {
      url = "/product/index?category=$categoryId&ignore=$ignore";
    }
    Map response = await httpManager.get(
      url: url,
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJson(e);
    }).toList();
    return products;
  }

  Future<List<Product>> search(String keyword) async {
    Map response = await httpManager.get(
      url: "/product/search?keyword=$keyword",
    );
    List responseRaw = response['data'];
    List<Product> products = responseRaw.map((e) {
      return Product.fromJson(e);
    }).toList();
    return products;
  }

  Future<Product?> one(int id) async {
    Map response = await httpManager.get(
      url: "/product/one?id=$id",
    );
    if (response['data'] == null) {
      return null;
    }
    List feedbacksRaw = response['data']['feedbacks'];
    ProductCart? cart;
    if (response['data']['cart'] != null) {
      cart = ProductCart.fromJson(response['data']['cart']);
    }
    Product product = Product.fromOne(
      response['data']['product'],
      cart: cart,
      feedbacks: feedbacksRaw.map((e) {
        return ProductFeedback.fromJson(e);
      }).toList(),
    );
    return product;
  }
}
