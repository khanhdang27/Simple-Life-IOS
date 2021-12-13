import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/screens/cart/product_card_horizontal_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_card_horizontal.dart';

class ProductWithHorizontalItem extends StatelessWidget {
  final bool confirm;

  ProductWithHorizontalItem({this.confirm = false}) {
    AppBloc.cartBloc.add(CartGet());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is CartSuccess) {
          return SizedBox(
            child: ListView(
              children: state.products.map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: !confirm
                      ? ProductCardHorizontal(product: e)
                      : ProductCardHorizontalConfirm(product: e),
                );
              }).toList(),
              scrollDirection: Axis.vertical,
              itemExtent: 260,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
      bloc: AppBloc.cartBloc,
    );
  }
}
