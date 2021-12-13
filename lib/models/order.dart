import 'package:baseproject/models/models.dart';
import 'package:intl/intl.dart';

class Order {
  static const Map PAYMENT_STATUS = {10: 'orderPaid', -10: 'orderUnpaid'};
  static const Map ORDER_STATUS = {
    30: 'orderCreated',
    20: 'orderDelivery',
    10: 'orderDone',
    -10: 'orderCancel',
    -20: 'orderRollback'
  };
  static const Map PAYMENT_METHOD = {
    10: 'orderPaypal',
    20: 'orderCreditCard',
    30: 'orderCash',
    40: 'orderBank'
  };

  final int id;
  final String number;
  final String? deliveryAddress;
  final double subtotal;
  final double total;
  final int status;
  final int? paymentStatus;
  final int? paymentMethod;
  final String createdAt;
  List<OrderDetail>? details;

  Order({
    required this.id,
    required this.number,
    this.deliveryAddress,
    required this.subtotal,
    required this.total,
    required this.status,
    this.paymentStatus,
    this.paymentMethod,
    required this.createdAt,
    this.details,
  });

  factory Order.fromJson(json) {
    List details = json['details'];
    int timeStamp = int.parse(json['created_at'] ?? '0');
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return Order(
        id: int.parse(json['id']),
        number: json['number'],
        deliveryAddress: json['delivery_address'],
        subtotal: double.parse(json['subtotal']),
        total: double.parse(json['total']),
        status: int.parse(json['status']),
        paymentStatus: int.parse(json['payment_status']),
        paymentMethod: int.parse(json['payment_method']),
        createdAt: DateFormat('dd/MM/yyyy hh:mma')
            .format(dateTime)
            .toString()
            .toLowerCase(),
        details: details.map((e) {
          return OrderDetail.fromJson(e);
        }).toList());
  }
}

class OrderDetail {
  final int id;
  final int quantity;
  final double price;
  final double amount;
  final Product product;

  OrderDetail({
    required this.id,
    required this.quantity,
    required this.price,
    required this.amount,
    required this.product,
  });

  factory OrderDetail.fromJson(json) {
    return OrderDetail(
      id: int.parse(json['id']),
      quantity: int.parse(json['quantity']),
      price: double.parse(json['unit_price']),
      amount: double.parse(json['amount']),
      product: Product.fromJson(json['product']),
    );
  }
}
