import 'package:baseproject/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_card_horizontal.dart';

class ProductWithHorizontalItem extends StatelessWidget {
  ProductWithHorizontalItem() {
    AppBloc.favoriteBloc.add(FavoriteGetList());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder(
        builder: (context, state) {
          if (state is FavoriteGetListSuccess) {
            return ListView(
              children: state.products.map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ProductCardHorizontal(product: e),
                );
              }).toList(),
              scrollDirection: Axis.vertical,
              itemExtent: 250,
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        bloc: AppBloc.favoriteBloc,
      ),
    );
  }
}
