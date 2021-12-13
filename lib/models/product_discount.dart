import 'package:baseproject/models/discount.dart';

class ProductDiscount {
  final int id;
  final Discount discount;
  final double discountPrice;

  ProductDiscount({
    required this.id,
    required this.discount,
    required this.discountPrice,
  });

  factory ProductDiscount.fromJson(Map json) {
    return ProductDiscount(
      id: int.parse(json['id']),
      discount: Discount.fromJson(json['discount']),
      discountPrice: double.parse(json['discount_price']),
    );
  }
}
