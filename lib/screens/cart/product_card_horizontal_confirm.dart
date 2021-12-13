import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductCardHorizontalConfirm extends StatefulWidget {
  final Product product;

  const ProductCardHorizontalConfirm({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductCardHorizontalConfirmState createState() =>
      _ProductCardHorizontalConfirmState();
}

class _ProductCardHorizontalConfirmState
    extends State<ProductCardHorizontalConfirm> {
  late int _quantity;

  @override
  void initState() {
    _quantity = widget.product.inCart ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColor.rBMain),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: widget.product.discountPrice != null
                                ? Text(
                                    "\$${widget.product.discountPrice}",
                                    style: TextStyle(
                                        color: AppColor.pinkLight,
                                        fontFamily: AppFont.madeTommySoft,
                                        fontWeight: AppFont.wRegular,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                : null,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "\$${widget.product.price}",
                              style: TextStyle(
                                fontFamily: AppFont.madeTommySoft,
                                fontWeight: AppFont.wMedium,
                              ),
                            ),
                          ),
                        ],
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
                    child: Icon(
                      Icons.delete,
                      size: 26,
                    ),
                    onTap: () {
                      AppBloc.cartBloc.add(
                        CartRemove(productId: widget.product.id),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    radius: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: SingleChildScrollView(
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 15,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            AppIcon.cart,
                            color: AppColor.rBMain,
                            size: 20,
                          ),
                          Text(
                            AppLocalizations.t(context, 'addToCart'),
                            style: TextStyle(
                              fontFamily: AppFont.madeTommySoft,
                              fontWeight: AppFont.wBold,
                            ),
                          ),
                        ],
                      ),
                      scrollDirection: Axis.horizontal,
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
                ),
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    children: [
                      GestureDetector(
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontWeight: AppFont.wMedium,
                            fontSize: 25,
                            fontFamily: AppFont.madeTommySoft,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (_quantity > 1) {
                              _quantity--;
                            }
                          });
                        },
                      ),
                      Text(
                        "$_quantity",
                        style: TextStyle(
                          fontWeight: AppFont.wMedium,
                          fontSize: 25,
                          fontFamily: AppFont.madeTommySoft,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontWeight: AppFont.wMedium,
                            fontSize: 25,
                            fontFamily: AppFont.madeTommySoft,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    child: SingleChildScrollView(
                      child: Text(
                        "${widget.product.amount}",
                        style: TextStyle(
                          fontWeight: AppFont.wMedium,
                          fontSize: 25,
                          fontFamily: AppFont.madeTommySoft,
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
