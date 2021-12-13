import 'dart:convert';

import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final double? discountPrice;
  final ProductDiscount? productDiscount;
  final String? thumbnail;
  final Category category;
  final double? score;
  final int? inCart;
  final double? amount;
  final List<String>? gallery;
  final String? description;
  final ProductCart? cart;
  final List<ProductFeedback>? feedbacks;
  final int inventory;
  final int? sold;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.thumbnail,
    this.score,
    this.inCart,
    this.discountPrice,
    this.amount,
    this.gallery,
    this.description,
    this.cart,
    this.feedbacks,
    required this.inventory,
    this.sold,
    this.productDiscount,
  });

  static ProductDiscount? productDiscountHandler(json) {
    try {
      List productDiscountsRaw = json['productDiscounts'];
      List<ProductDiscount> productDiscounts = productDiscountsRaw.map((e) {
        return ProductDiscount.fromJson(e);
      }).toList();
      productDiscounts.sort((a, b) {
        return a.discountPrice.compareTo(b.discountPrice);
      });
      return productDiscounts[0];
    } catch (_) {
      return null;
    }
  }

  factory Product.fromJson(Map json) {
    String? thumb;
    try {
      Map thumbMap = jsonDecode(json['thumbnail']);
      thumb = AppConfig.baseUrl + thumbMap['path'];
    } catch (_) {}
    ProductDiscount? productDc = productDiscountHandler(json);
    return Product(
      id: int.parse(json['id']),
      name: json['name'],
      price: double.parse(json['price']),
      thumbnail: thumb,
      category: Category.fromJson(json['category']),
      score: double.parse(json['score'] ?? '0'),
      inCart: int.parse(json['in_cart'] ?? '0'),
      amount: productDc != null
          ? productDc.discountPrice * int.parse(json['quantity'] ?? '0')
          : double.parse(json['total'] ?? '0'),
      discountPrice: productDc != null ? productDc.discountPrice : null,
      productDiscount: productDc,
      inventory: int.parse(json['inventory'] ?? '0'),
    );
  }

  factory Product.fromJsonCart(Map json) {
    String? thumb;
    try {
      Map thumbMap = jsonDecode(json['thumbnail']);
      thumb = AppConfig.baseUrl + thumbMap['path'];
    } catch (_) {}
    ProductDiscount? productDc = productDiscountHandler(json);
    return Product(
      id: int.parse(json['id']),
      name: json['name'],
      price: double.parse(json['price']),
      thumbnail: thumb,
      category: Category.fromJson(json['category']),
      score: double.parse(json['score'] ?? '0'),
      inCart: int.parse(json['quantity'] ?? '0'),
      amount: productDc != null
          ? productDc.discountPrice * int.parse(json['quantity'] ?? '0')
          : double.parse(json['total'] ?? '0'),
      discountPrice: productDc != null ? productDc.discountPrice : null,
      productDiscount: productDc,
      inventory: int.parse(json['inventory'] ?? '0'),
    );
  }

  factory Product.fromOne(
    Map json, {
    ProductCart? cart,
    List<ProductFeedback>? feedbacks,
  }) {
    String? thumb;
    List<String> gallery = [];
    try {
      Map thumbMap = jsonDecode(json['thumbnail']);
      thumb = AppConfig.baseUrl + thumbMap['path'];
    } catch (_) {}
    try {
      if (json['gallery'] != null) {
        var galleryRaw = jsonDecode(json['gallery']);
        if (galleryRaw is List) {
          gallery = galleryRaw.map((e) {
            String temp = AppConfig.baseUrl + e['path'];
            return temp;
          }).toList();
        }
        if (galleryRaw is Map) {
          galleryRaw.forEach((key, value) {
            String temp = AppConfig.baseUrl + value['path'];
            gallery.add(temp);
          });
        }
      }
    } catch (_) {}
    ProductDiscount? productDc = productDiscountHandler(json);
    return Product(
      id: int.parse(json['id']),
      name: json['name'],
      price: double.parse(json['price']),
      thumbnail: thumb,
      category: Category.fromJson(json['category']),
      cart: cart,
      feedbacks: feedbacks,
      description: json['description'],
      gallery: gallery,
      inventory: int.parse(json['inventory'] ?? '0'),
      sold: int.parse(json['sold']),
      discountPrice: productDc != null ? productDc.discountPrice : null,
      productDiscount: productDc,
    );
  }

  factory Product.fromJsonDbCart(Map json, int inCart) {
    String? thumb;
    try {
      Map thumbMap = jsonDecode(json['thumbnail']);
      thumb = AppConfig.baseUrl + thumbMap['path'];
    } catch (_) {}
    ProductDiscount? productDc = productDiscountHandler(json);
    return Product(
      id: int.parse(json['id']),
      name: json['name'],
      price: double.parse(json['price']),
      thumbnail: thumb,
      category: Category.fromJson(json['category']),
      score: double.parse(json['score'] ?? '0'),
      inCart: inCart,
      amount: productDc != null
          ? productDc.discountPrice * inCart
          : double.parse(json['price']) * inCart,
      discountPrice: productDc != null ? productDc.discountPrice : null,
      productDiscount: productDc,
      inventory: int.parse(json['inventory'] ?? '0'),
    );
  }
}
