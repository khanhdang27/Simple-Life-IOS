import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/app_color.dart';
import 'package:baseproject/configs/app_font.dart';
import 'package:baseproject/configs/app_route.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    AppBloc.orderBloc.add(OrderGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: BlocBuilder(
        bloc: AppBloc.orderBloc,
        builder: (context, state) {
          if (state is OrderGetSuccess) {
            return Column(
              children: state.orders.map((e) {
                return _OrderItem(order: e);
              }).toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final Order order;

  const _OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoute.orderDetail,
          arguments: {'order': order},
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColor.brownPink,
            ),
          ),
        ),
        child: Column(
          children: [
            _RowTitle(
              first: "訂單編號",
              second: "${order.number}",
            ),
            _RowTitle(
              first: "日期",
              second: "${order.createdAt}",
            ),
            order.details != null
                ? Wrap(
                    children: order.details!.map((e) {
                      return _RowItem(
                        first: "${e.product.name}",
                        second: "x${e.quantity}",
                        third: '\$${e.amount}',
                      );
                    }).toList(),
                  )
                : SizedBox(),
            _RowItem(
              first: '進度',
              second:
                  "${AppLocalizations.t(context, Order.ORDER_STATUS[order.status])}",
            ),
            _RowItem(
              first: '總數',
              third: '\$${order.total}',
            ),
            _RowItem(
              first: '運費',
              second:
                  "${AppLocalizations.t(context, Order.PAYMENT_STATUS[order.paymentStatus])}",
            ),
            _RowItem(
              first: '付款方法',
              second:
                  "${AppLocalizations.t(context, Order.PAYMENT_METHOD[order.paymentMethod])}",
            ),
          ],
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final String first;
  final String? second;
  final String? third;

  const _RowItem({Key? key, required this.first, this.second, this.third})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            first,
            style: TextStyle(
              fontFamily: AppFont.monospace,
              fontWeight: AppFont.wRegular,
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: second != null
              ? Text(
                  second!,
                  style: TextStyle(
                    fontFamily: AppFont.madeTommySoft,
                    fontWeight: AppFont.wMedium,
                  ),
                )
              : Container(),
          flex: 3,
        ),
        Expanded(
          child: third != null
              ? Align(
                  child: Text(
                    third!,
                    style: TextStyle(
                      fontFamily: AppFont.madeTommySoft,
                      fontWeight: AppFont.wMedium,
                    ),
                  ),
                  alignment: Alignment.centerRight,
                )
              : SizedBox(),
          flex: 1,
        ),
      ],
    );
  }
}

class _RowTitle extends StatelessWidget {
  final String first;
  final String second;

  const _RowTitle({Key? key, required this.first, required this.second})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            first,
            style: TextStyle(
              fontFamily: AppFont.madeTommySoft,
              fontWeight: AppFont.wBold,
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Text(
            second,
            style: TextStyle(
              fontFamily: AppFont.madeTommySoft,
              fontWeight: AppFont.wMedium,
            ),
          ),
          flex: 3,
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}
