import 'package:baseproject/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_card_horizontal.dart';

class ProductListWithHorizontalItem extends StatelessWidget {
  ProductListWithHorizontalItem() {
    AppBloc.productBloc.add(ProductGetHot());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is ProductGetHotSuccess) {
          return SizedBox(
            child: ListView(
              children: state.products.map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ProductCardHorizontal(product: e),
                );
              }).toList(),
              scrollDirection: Axis.vertical,
              itemExtent: 200,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
      bloc: AppBloc.productBloc,
      buildWhen: (previous, current) {
        return current is ProductGetHotSuccess;
      },
    );
  }
}
