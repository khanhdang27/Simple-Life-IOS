import 'dart:io';
import 'dart:typed_data';

import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:baseproject/screens/product/related_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final controller = ScreenshotController();

  @override
  void initState() {
    AppBloc.productDetailBloc.add(
      ProductDetailGet(productId: widget.productId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder(
        bloc: AppBloc.productDetailBloc,
        builder: (context, state) {
          if (state is ProductDetailGetSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Screenshot(
                  controller: controller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppAsset.productBg),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              child: state.product.thumbnail != null
                                  ? Image.network(
                                      state.product.thumbnail!,
                                      height: 200,
                                    )
                                  : SizedBox(),
                              onTap: () {
                                Navigator.pushNamed(context, AppRoute.productDetail);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${state.product.name}",
                          style: TextStyle(
                            fontFamily: AppFont.monospace,
                            fontWeight: AppFont.wMedium,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.t(context, 'sold') + " ${state.product.sold}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: AppFont.monospace,
                                    fontWeight: AppFont.wBold,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: AppColor.pinkLight,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Text(
                                    AppLocalizations.t(context,
                                        state.product.inventory < 1 ? 'soldOut' : 'inStock'),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppFont.monospace,
                                      fontWeight: AppFont.wMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            state.product.discountPrice != null
                                ? Text(
                                    "\$${state.product.price}",
                                    style: TextStyle(
                                      color: AppColor.pinkLight,
                                      fontFamily: AppFont.madeTommySoft,
                                      fontWeight: AppFont.wMedium,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 20,
                                    ),
                                  )
                                : SizedBox(),
                            Text(
                              "\$${state.product.discountPrice ?? state.product.price}",
                              style: TextStyle(
                                  fontFamily: AppFont.madeTommySoft,
                                  fontWeight: AppFont.wMedium,
                                  fontSize: 20),
                            ),
                            state.product.inventory < 1
                                ? SizedBox()
                                : _AddCart(
                                    productId: state.product.id,
                                    quantity: state.product.cart != null
                                        ? state.product.cart!.quantity
                                        : 1,
                                  ),
                            state.product.description != null &&
                                    state.product.description!.isNotEmpty
                                ? Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          AppLocalizations.t(context, 'productIntro'),
                                          style: TextStyle(
                                            fontFamily: AppFont.monospace,
                                            fontWeight: AppFont.wMedium,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: Html(data: "${state.product.description ?? ''}"),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ///end screen shot

                _Social(productId: state.product.id, callback: () async {
                  final image = await controller.capture();
                  saveAndShare(image,state.product.name);
                },),

                ///Gallery
                state.product.gallery != null
                    ? _Gallery(
                        gallery: state.product.gallery!,
                      )
                    : SizedBox(),

                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.t(context, 'deliveryReturn'),
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.t(context, 'storeTerm'),
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                _RelatedHeader(title: '其他推薦'),
                RelatedList(
                  category: state.product.category,
                  ignore: state.product.id,
                ),
                _FeedbackHeader(title: '用家評價', productId: state.product.id),
                _Feedback(
                  productFeedbacks: state.product.feedbacks != null ? state.product.feedbacks! : [],
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Future saveAndShare(Uint8List? bytes, String name) async {
  final directory = await getApplicationDocumentsDirectory();
  final image = File('${directory.path}/$name.png');
  image.writeAsBytesSync(bytes!);
  final text = "Shared from Simply Life";
  await Share.shareFiles([image.path],text: text);
}

class _AddCart extends StatefulWidget {
  final int productId;
  final int quantity;

  const _AddCart({Key? key, required this.productId, required this.quantity}) : super(key: key);

  @override
  __AddCartState createState() => __AddCartState();
}

class __AddCartState extends State<_AddCart> {
  int _quantity = 1;

  @override
  void initState() {
    _quantity = widget.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Wrap(
              children: [
                InkWell(
                  child: Text(
                    '-',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: AppFont.madeTommySoft,
                      fontWeight: AppFont.wRegular,
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    "$_quantity",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: AppFont.madeTommySoft,
                      fontWeight: AppFont.wRegular,
                    ),
                  ),
                ),
                InkWell(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: AppFont.madeTommySoft,
                      fontWeight: AppFont.wRegular,
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
          InkWell(
            onTap: () {
              AppBloc.cartBloc.add(
                CartAdd(
                  productId: widget.productId,
                  quantity: _quantity,
                ),
              );
            },
            radius: 10,
            borderRadius: BorderRadius.circular(10),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(AppIcon.cart),
                ),
                Text(
                  AppLocalizations.t(context, 'addToCart'),
                  style: TextStyle(
                    fontWeight: AppFont.wMedium,
                    fontFamily: AppFont.monospace,
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

class _Social extends StatelessWidget {
  final int productId;
  final callback;

  const _Social({Key? key, required this.productId, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: callback,
          child: Column(
            children: [
              Icon(
                Icons.share,
                size: 30,
              ),
              Text(
                AppLocalizations.t(context, 'share'),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFont.monospace,
                  fontWeight: AppFont.wMedium,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            InkWell(
              child: BlocBuilder(
                builder: (context, state) {
                  IconData iconData = Icons.favorite_border;
                  if (state is FavoriteGetListSuccess) {
                    if (state.productIds.contains(productId)) {
                      iconData = Icons.favorite;
                    }
                  }
                  return Icon(
                    iconData,
                    size: 30,
                  );
                },
                bloc: AppBloc.favoriteBloc,
              ),
              onTap: () {
                AppBloc.favoriteBloc.add(
                  FavoriteRequest(
                    productId: productId,
                  ),
                );
              },
            ),
            Text(
              AppLocalizations.t(context, 'addToList'),
              style: TextStyle(
                fontSize: 12,
                fontFamily: AppFont.monospace,
                fontWeight: AppFont.wMedium,
              ),
            ),
          ],
        ),
        BlocBuilder(
          builder: (context, state) {
            if (state is AuthSuccess) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.productFeedback,
                    arguments: {'id': productId},
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.message,
                      size: 30,
                    ),
                    Text(
                      AppLocalizations.t(context, 'writeReview'),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: AppFont.monospace,
                        fontWeight: AppFont.wMedium,
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox();
          },
          bloc: AppBloc.authBloc,
        ),
      ],
    );
  }
}

class _Gallery extends StatelessWidget {
  final List gallery;

  const _Gallery({Key? key, required this.gallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gallery.map((e) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.pinkLight,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                child: Image.network(
                  e,
                  height: 200,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.productDetail);
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _Feedback extends StatelessWidget {
  final List<ProductFeedback> productFeedbacks;

  const _Feedback({Key? key, required this.productFeedbacks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: productFeedbacks.map((e) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.whiteMain,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(5, 6), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${e.userName}",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "${e.createdAt ?? ''}",
                style: TextStyle(fontSize: 12),
              ),
              RatingBar(
                initialRating: e.score,
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
                  Text(
                    AppLocalizations.t(context, 'points'),
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "${e.feedback}",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppFont.madeTommySoft,
                          fontWeight: AppFont.wRegular,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _FeedbackHeader extends StatelessWidget {
  final String title;
  final int productId;

  const _FeedbackHeader({
    Key? key,
    required this.title,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAsset.titleBg),
                fit: BoxFit.fill,
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: AppFont.monospace,
                fontWeight: AppFont.wBold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
            child: BlocBuilder(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.productFeedback,
                        arguments: {'id': productId},
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColor.pinkLight,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        '有現貨',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
              bloc: AppBloc.authBloc,
            ),
          ),
        ),
      ],
    );
  }
}

class _RelatedHeader extends StatelessWidget {
  final String title;
  final String? thumbnail;

  const _RelatedHeader({Key? key, required this.title, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: AppFont.monospace,
            fontWeight: AppFont.wBold,
          ),
        ),
      ),
    );
  }
}
