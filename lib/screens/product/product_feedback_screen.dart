import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductFeedbackScreen extends StatefulWidget {
  final int productId;

  const ProductFeedbackScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  _ProductFeedbackScreenState createState() => _ProductFeedbackScreenState();
}

class _ProductFeedbackScreenState extends State<ProductFeedbackScreen> {
  TextEditingController _feedbackCtrl = TextEditingController();
  double _rating = 5;

  @override
  void dispose() {
    _feedbackCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is FeedbackAddSuccess) {
          AppBloc.productDetailBloc.add(ProductDetailGet(
            productId: widget.productId,
          ));
          Navigator.pop(context);
        }
      },
      listenWhen: (previous, current) => current is FeedbackAddSuccess,
      bloc: AppBloc.feedbackBloc,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBar(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              onRatingUpdate: (rating) {
                _rating = rating;
              },
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              itemSize: 35,
              ratingWidget: RatingWidget(
                full: Icon(AppIcon.star, color: AppColor.pinkLight),
                empty: Icon(AppIcon.star_empty, color: AppColor.pinkLight),
                half: Icon(AppIcon.star_half_alt, color: AppColor.pinkLight),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.pinkLight),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: TextField(
                controller: _feedbackCtrl,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              onTap: () {
                if (_feedbackCtrl.text.isNotEmpty) {
                  AppBloc.feedbackBloc.add(
                    FeedbackAdd(
                      productId: widget.productId,
                      score: _rating,
                      feedback: _feedbackCtrl.text,
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                decoration: BoxDecoration(
                  color: AppColor.pinkLight,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
