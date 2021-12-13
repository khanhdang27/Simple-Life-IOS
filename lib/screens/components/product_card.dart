import 'package:baseproject/blocs/app_bloc.dart';
import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoute.productDetail,
          arguments: {'id': product.id},
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAsset.productBg),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    product.thumbnail != null
                        ? Image.network(product.thumbnail!)
                        : Container(),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: BlocBuilder(
                          builder: (context, state) {
                            Color? color;
                            if (state is FavoriteGetListSuccess) {
                              if (state.productIds.contains(product.id)) {
                                color = AppColor.whiteMain;
                              }
                            }
                            return Icon(
                              AppIcon.heart,
                              size: 20,
                              color: color,
                            );
                          },
                          bloc: AppBloc.favoriteBloc,
                        ),
                        onTap: () {
                          AppBloc.favoriteBloc.add(
                            FavoriteRequest(
                              productId: product.id,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: AppFont.monospace,
                        fontWeight: AppFont.wMedium,
                      ),
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                  RatingBar(
                    initialRating: product.score ?? 0,
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
                  Row(
                    children: [
                      Expanded(
                        child: _Price(
                          price: product.price,
                          newPrice: product.discountPrice,
                        ),
                      ),
                      Builder(
                        builder: (BuildContext context) {
                          if (product.inventory < 1) {
                            return SizedBox();
                          }
                          return InkWell(
                            child: Icon(AppIcon.cart),
                            onTap: () {
                              AppBloc.cartBloc.add(
                                CartAdd(
                                  productId: product.id,
                                  quantity: 1,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
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
