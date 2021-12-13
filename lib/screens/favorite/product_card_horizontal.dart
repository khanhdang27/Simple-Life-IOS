import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:baseproject/screens/components/checkbox.dart' as MyCheckBox;
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
  late int _quantity;

  @override
  void initState() {
    _quantity = widget.product.inCart ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAsset.productBg),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Stack(
                    children: [
                      InkWell(
                        child: widget.product.thumbnail != null
                            ? Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(maxHeight: 140),
                                child: Image.network(
                                  widget.product.thumbnail!,
                                ),
                              )
                            : SizedBox(),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.productDetail,
                            arguments: {'id': widget.product.id},
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BlocBuilder(
                          builder: (context, state) {
                            bool _checkValue = false;
                            if (state is FavoriteCheckAllSuccess) {
                              _checkValue = state.value;
                            }
                            if (state is FavoriteCheckOneSuccess) {
                              _checkValue =
                                  state.ids.contains(widget.product.id);
                            }
                            return MyCheckBox.Checkbox(
                              value: _checkValue,
                              onChanged: (bool? value) {
                                AppBloc.favoriteCheckBloc.add(
                                  FavoriteCheckOne(
                                    id: widget.product.id,
                                    value: value!,
                                  ),
                                );
                              },
                            );
                          },
                          bloc: AppBloc.favoriteCheckBloc,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignment: Alignment.center,
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 15,
                    children: [
                      InkWell(
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontWeight: AppFont.wMedium,
                            fontSize: 30,
                            fontFamily: AppFont.madeTommySoft,
                          ),
                        ),
                        onTap: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        "$_quantity",
                        style: TextStyle(
                          fontWeight: AppFont.wMedium,
                          fontSize: 30,
                          fontFamily: AppFont.madeTommySoft,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontWeight: AppFont.wMedium,
                            fontSize: 30,
                            fontFamily: AppFont.madeTommySoft,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                      InkWell(
                        child: Icon(
                          AppIcon.cart,
                          color: AppColor.rBMain,
                          size: 30,
                        ),
                        onTap: () {
                          AppBloc.cartBloc.add(
                            CartAdd(
                              productId: widget.product.id,
                              quantity: _quantity,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.productDetail,
                          arguments: {'id': widget.product.id},
                        );
                      },
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppFont.monospace,
                          fontWeight: AppFont.wMedium,
                        ),
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
        ],
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
