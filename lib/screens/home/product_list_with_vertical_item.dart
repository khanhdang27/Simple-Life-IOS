import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/screens/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListWithVerticalItem extends StatelessWidget {
  ProductListWithVerticalItem() {
    AppBloc.productBloc.add(ProductGetMaybeLike());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is ProductGetMaybeLikeSuccess) {
          return SizedBox(
            height: 330,
            child: ListView(
              children: state.products.map((e) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: ProductCard(product: e),
                );
              }).toList(),
              scrollDirection: Axis.horizontal,
              itemExtent: 200,
              padding: EdgeInsets.all(10),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
      bloc: AppBloc.productBloc,
      buildWhen: (previous, current) {
        return current is ProductGetMaybeLikeSuccess;
      },
    );
  }
}
