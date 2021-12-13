import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:flutter/cupertino.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          _HeaderOrder(order: order),
          _BodyOrder(order: order),
          _FooterOrder(order: order),
        ],
      ),
    );
  }
}

class _HeaderOrder extends StatelessWidget {
  final Order order;

  const _HeaderOrder({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          _RowHeader(first: "訂單編號", second: "${order.number}"),
          _RowHeader(first: "日期", second: "${order.createdAt}"),
          _RowHeader(
              first: "進度",
              second:
                  "${AppLocalizations.t(context, Order.ORDER_STATUS[order.status])}"),
        ],
      ),
    );
  }
}

class _RowHeader extends StatelessWidget {
  final String? first;
  final String? second;

  const _RowHeader({Key? key, this.first, this.second}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            first!,
            style: TextStyle(
              fontFamily: AppFont.monospace,
              fontWeight: AppFont.wBold,
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Text(
            second!,
            style: TextStyle(
              fontFamily: AppFont.madeTommySoft,
              fontWeight: AppFont.wMedium,
            ),
          ),
          flex: 3,
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}

class _FooterOrder extends StatelessWidget {
  final Order order;

  const _FooterOrder({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Text("送到上門"),
                Text("${order.deliveryAddress ?? '門市自取'}",
                    style: TextStyle(
                      fontFamily: AppFont.monospace,
                      fontWeight: AppFont.wMedium,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Text("付款方法"),
                Text(
                    "${AppLocalizations.t(context, Order.PAYMENT_METHOD[order.paymentMethod])}",
                    style: TextStyle(
                      fontFamily: AppFont.madeTommySoft,
                      fontWeight: AppFont.wMedium,
                    )),
              ],
            ),
          ),
          Wrap(
            direction: Axis.vertical,
            children: [
              Text("運費"),
              Text(
                  "${AppLocalizations.t(context, Order.PAYMENT_STATUS[order.paymentStatus])}",
                  style: TextStyle(
                    fontFamily: AppFont.madeTommySoft,
                    fontWeight: AppFont.wMedium,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyOrder extends StatelessWidget {
  final Order order;

  const _BodyOrder({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Container(
            child: Text(
              "貨品",
              style: TextStyle(
                fontFamily: AppFont.monospace,
                fontWeight: AppFont.wBold,
              ),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColor.brownPink,
                ),
              ),
            ),
          ),
          _ProductList(order: order),
          _OrderStatus(),
          _Promotion(),
          _Total(order: order),
        ],
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  final Order order;

  const _ProductList({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: order.details != null
          ? Column(
              children: order.details!.map((e) {
                return _ProductDetail(orderDetail: e);
              }).toList(),
            )
          : SizedBox(),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.brownPink,
          ),
        ),
      ),
    );
  }
}

class _ProductDetail extends StatelessWidget {
  final OrderDetail orderDetail;

  const _ProductDetail({Key? key, required this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "${orderDetail.product.name}",
            style: TextStyle(
              fontFamily: AppFont.monospace,
              fontWeight: AppFont.wRegular,
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Text("x${orderDetail.quantity}",
              style: TextStyle(
                fontFamily: AppFont.madeTommySoft,
                fontWeight: AppFont.wMedium,
              )),
          flex: 3,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text("\$${orderDetail.amount}",
                style: TextStyle(
                  fontFamily: AppFont.madeTommySoft,
                  fontWeight: AppFont.wMedium,
                )),
          ),
          flex: 1,
        ),
      ],
    );
  }
}

class _OrderStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text('運費'),
          ),
          Expanded(
            child: Text('送到上門'),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('\$0.00',
                  style: TextStyle(
                    fontFamily: AppFont.madeTommySoft,
                    fontWeight: AppFont.wMedium,
                  )),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.brownPink,
          ),
        ),
      ),
    );
  }
}

class _Promotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('積分折扣'),
                flex: 2,
              ),
              Expanded(
                child: Container(),
                flex: 3,
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text('優惠碼'),
                flex: 2,
              ),
              Expanded(
                child: Container(),
                flex: 3,
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.brownPink,
          ),
        ),
      ),
    );
  }
}

class _Total extends StatelessWidget {
  final Order order;

  const _Total({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text('總數'),
                flex: 2,
              ),
              Expanded(
                child: Container(),
                flex: 3,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("\$${order.total}",
                      style: TextStyle(
                        fontFamily: AppFont.madeTommySoft,
                        fontWeight: AppFont.wMedium,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
