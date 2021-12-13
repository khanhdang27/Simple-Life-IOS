import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/screens/components/components.dart';
import 'package:baseproject/screens/home/product_list_with_horizontal_item.dart';
import 'package:baseproject/screens/home/product_list_with_vertical_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category.dart' as CategoryWidget;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CategoryWidget.Category(),
      BlocBuilder(
        bloc: AppBloc.viewBloc,
        builder: (context, state) {
          if (state is ViewCategorySuccess) {
            return _CategoryView();
          }
          if (state is ViewHomeSuccess) {
            return _HomeView();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ]);
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String? thumbnail;

  const _Title({Key? key, required this.title, this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [
      Text(title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: AppFont.monospace,
            fontWeight: AppFont.wBold,
          ))
    ];
    if (thumbnail != null) {
      content.add(Padding(
        padding: EdgeInsets.only(left: 10),
        child: Image.network(thumbnail!, height: 30, width: 30),
      ));
    }
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.titleBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Wrap(
          children: content,
        ),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _Title(title: AppLocalizations.t(context, "hotDeals")),
        ProductListWithHorizontalItem(),
        _Title(title: AppLocalizations.t(context, "youMightLike")),
        ProductListWithVerticalItem()
      ],
    );
  }
}

class _CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is ProductGetByCategorySuccess) {
          return Wrap(children: [
            _Title(
              title: state.category.name,
              thumbnail: state.category.thumbnail,
            ),
            ProductGrid(
              childAspectRatio: 293.91 / 484.95,
              maxCrossAxisExtent: 293.91,
              products: state.products,
            ),
          ]);
        }
        return Center(child: CircularProgressIndicator());
      },
      bloc: AppBloc.productBloc,
    );
  }
}
