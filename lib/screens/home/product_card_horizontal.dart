import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCardHorizontal extends StatefulWidget {
  final Product product;

  const ProductCardHorizontal({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductCardHorizontalState createState() => _ProductCardHorizontalState();
}

class _ProductCardHorizontalState extends State<ProductCardHorizontal> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoute.productDetail,
          arguments: {'id': widget.product.id},
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAsset.productBg),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: widget.product.thumbnail != null
                    ? Image.network(widget.product.thumbnail!)
                    : Container(),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.monospace,
                          fontWeight: AppFont.wMedium,
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                    ),
                    RatingBar(
                      initialRating: widget.product.score ?? 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      onRatingUpdate: (rating) {},
                      ignoreGestures: true,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemSize: 22,
                      ratingWidget: RatingWidget(
                        full: Icon(AppIcon.star, color: AppColor.pinkLight),
                        empty: Icon(
                          AppIcon.star_empty,
                          color: AppColor.pinkLight,
                        ),
                        half: Icon(
                          AppIcon.star_half_alt,
                          color: AppColor.pinkLight,
                        ),
                      ),
                    ),
                    _Price(
                      price: widget.product.price,
                      newPrice: widget.product.discountPrice,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(right: 10, top: 10),
                child: InkWell(
                  child: BlocBuilder(
                    builder: (context, state) {
                      IconData iconData = Icons.favorite_outline_sharp;
                      if (state is FavoriteGetListSuccess) {
                        if (state.productIds.contains(widget.product.id)) {
                          iconData = Icons.favorite;
                        }
                      }
                      return Icon(
                        iconData,
                        size: 30,
                        color: AppColor.pinkLight,
                      );
                    },
                    bloc: AppBloc.favoriteBloc,
                  ),
                  onTap: () {
                    AppBloc.favoriteBloc.add(
                      FavoriteRequest(productId: widget.product.id),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Price extends StatelessWidget {
  final double price;
  final double? newPrice;

  const _Price({Key? key, required this.price, this.newPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (newPrice != null) {
      widgets = [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            "\$$price",
            style: TextStyle(
                color: AppColor.pinkLight,
                fontFamily: AppFont.madeTommySoft,
                fontWeight: AppFont.wRegular,
                decoration: TextDecoration.lineThrough),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            '\$$newPrice',
            style: TextStyle(
              fontFamily: AppFont.madeTommySoft,
              fontWeight: AppFont.wMedium,
            ),
          ),
        ),
      ];
    } else {
      widgets = [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            '\$$price',
            style: TextStyle(
              fontFamily: AppFont.madeTommySoft,
              fontWeight: AppFont.wMedium,
            ),
          ),
        ),
      ];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
