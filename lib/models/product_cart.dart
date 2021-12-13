class ProductCart {
  final int productId;
  final int customerId;
  final int quantity;
  final String createdAt;

  ProductCart({
    required this.productId,
    required this.customerId,
    required this.quantity,
    required this.createdAt,
  });

  factory ProductCart.fromJson(Map json) {
    return ProductCart(
      productId: int.parse(json['product_id']),
      customerId: int.parse(json['customer_id']),
      quantity: int.parse(json['quantity']),
      createdAt: json['created_at'],
    );
  }
}
