import 'package:baseproject/blocs/blocs.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
          builder: (context, state) {
            if (state is CouponGetAllSuccess) {
              return Column(
                children: state.coupons.map((e) {
                  return InkWell(
                      child: Coupon(
                    id: e.id ?? 0,
                    name: e.name ?? '',
                    value: e.value ?? '',
                  ));
                }).toList(),
              );
            }
            return SizedBox();
          },
          bloc: AppBloc.couponBloc,
          buildWhen: (previous, current) {
            return current is CouponGetAllSuccess;
          },
        ),
      ],
    );
  }
}

class Coupon extends StatelessWidget {
  final int id;
  final String name;
  final String value;

  const Coupon({Key? key, required this.id, required this.name, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String result = id.toString()+'-'+name+'-'+value;
        Navigator.pop(context, result);
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
          color: AppColor.whiteMain,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                  image: DecorationImage(image: AssetImage(AppAsset.bg), fit: BoxFit.fill),
                ),
              ),
            ),
            Expanded(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 135,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            name,
                            style: TextStyle(
                                color: AppColor.brownPink,
                                fontSize: 20,
                                fontWeight: AppFont.wMedium),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        AppLocalizations.t(context, 'discount') + ': ' + value,
                        style: TextStyle(
                            color: AppColor.blackContent,
                            fontSize: 14,
                            fontWeight: AppFont.wMedium),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
