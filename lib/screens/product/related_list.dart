import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/models/models.dart';
import 'package:baseproject/screens/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedList extends StatelessWidget {
  final Category category;
  final int ignore;

  RelatedList({required this.category, required this.ignore}) {
    AppBloc.productBloc.add(ProductGetByCategory(
      category: category,
      ignore: ignore,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is ProductGetByCategorySuccess) {
          if (state.products.length > 0) {
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
          return SizedBox();
        }
        return Center(child: CircularProgressIndicator());
      },
      bloc: AppBloc.productBloc,
    );
  }
}
